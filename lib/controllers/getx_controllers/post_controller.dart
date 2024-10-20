import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/post/post_model.dart';
import '../../model/post_with_user.dart';
import '../../model/user/user.dart' as my_user;
import '../utils/firestore_utils.dart';
import '../utils/constants.dart';
import '../utils/snackbar.dart';

class PostController extends GetxController {
  final FirestoreUtils _firestoreUtils = FirestoreUtils();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  List<Map<String, dynamic>> posts = [];
  int postLoadingLimit = 5;

  // Create a new post
  Future<bool> createPost(String postText, XFile? imageFile, RxList<String> tagsList) async {
    isLoading.value = true;

    try {
      String? imageUrl;
      if (imageFile != null) {
        imageUrl = await _firestoreUtils.uploadFileToStorage(
          folderName: 'postImages',
          file: File(imageFile.path),
        );
      } else {
        print('No image file provided.');
      }

      // Log the data that will be sent to Firestore
      final postData = {
        'ownerId': _auth.currentUser?.uid.toString() ?? "",
        'postText': postText,
        'postImage': imageUrl ?? '', // Use the uploaded image URL or an empty string if no image
        'tags': tagsList,
        'createdAt': DateTime.now().toIso8601String(),
        'comments': [], // Array of comments
        'likes': [], // Array of user IDs who liked the post
        'shares': [], // Array of user IDs who shared the post
      };
      print('Post data: $postData');

      // Create the post in Firestore
      await _firestoreUtils.addDocument(
        collectionName: posts_collection,
        data: postData,
      );

      showSuccessSnackbar("Post created successfully."); // This should work if context is correct.
      return true;
    } catch (e) {
      showErrorSnackbar('Error creating post: $e');
      print('Error creating post: $e');
      return false;
    } finally {
      isLoading.value = false;
      print('Loading state set to false.');
    }
  }

// Get all posts
  Future<List<Map<String, dynamic>>> getAllPosts() async {
    isLoading.value = true;
    List<Map<String, dynamic>> posts = [];
    try {
      // Get all documents as List<Map<String, dynamic>>
      posts = await _firestoreUtils.getAllDocuments(collectionName: posts_collection);
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      isLoading.value = false;
    }
    return posts;
  }

  Stream<List<PostWithUser>> getPostsStream() async* {
    final firestoreUtils = FirestoreUtils();

    // Fetching posts
    Query query = FirebaseFirestore.instance.collection(posts_collection).orderBy('createdAt', descending: true);
    print('Query created: $query'); // Debug: Log the query created.

    // Stream of posts
    yield* query.snapshots().asyncMap((QuerySnapshot querySnapshot) async {
      print('Received snapshot with ${querySnapshot.docs.length} documents'); // Debug: Log the number of documents received.

      List<PostModel> posts = querySnapshot.docs.map((doc) {
        return PostModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      print('Mapped ${posts.length} posts'); // Debug: Log the number of posts mapped.

      // Extract unique ownerIds from posts
      List<String> ownerIds = posts.map((post) => post.ownerId).toSet().toList();
      print('Unique ownerIds extracted: $ownerIds'); // Debug: Log the unique owner IDs.

      // Fetch users corresponding to ownerIds using FirestoreUtils
      List<Map<String, dynamic>> userDocuments = await firestoreUtils.getDocumentsWhereFieldIn(
        collectionName: 'users', // Assuming 'users' is your users collection name
        fieldName: 'uid', // Assuming 'uid' is the field name in the users collection
        fieldValues: ownerIds,
      );

      print('Fetched ${userDocuments.length} user documents for ownerIds'); // Debug: Log the number of user documents fetched.

      // Convert user documents to User objects one by one
      List<my_user.UserModel> users = [];
      for (var userData in userDocuments) {
        try {
          // Log the current user data being processed
          print('Processing user data: $userData'); // Debug: Log user data being processed
          var user = my_user.UserModel.fromMap(userData);
          users.add(user);
        } catch (e) {
          print('Error processing user data: $userData'); // Log the problematic user data
          print('Error details: $e'); // Log the error details
        }
      }

      print('Mapped ${users.length} users'); // Debug: Log the number of users mapped.

      // Map posts to include user data
      List<PostWithUser> postsWithUsers = posts.map((post) {
        // Attempt to find the owner
        my_user.UserModel? owner = users.firstWhere(
          (user) => user.uid == post.ownerId,
          orElse: () => my_user.UserModel(uid: '', name: '', email: '', password: '', profileImage: ''),
        );

        if (owner.uid.isEmpty) {
          print('Warning: Owner not found for post:'); // Debug: Log a warning if owner is not found.
        } else {
          print('Owner found for post: - Owner UID: ${owner.uid}'); // Debug: Log the owner found.
          print("Image ${owner.profileImage}");
        }

        return PostWithUser(post: post, user: owner);
      }).toList();

      print('Returning ${postsWithUsers.length} posts with user data'); // Debug: Log the number of posts with user data.

      return postsWithUsers;
    });
  }

  // Get a single post by ID
  Future<Map<String, dynamic>?> getPostById(String postId) async {
    isLoading.value = true;
    try {
      final DocumentSnapshot postDoc = await _firestoreUtils.getDocument(
        collectionName: posts_collection,
        docId: postId,
      );

      if (postDoc.exists) {
        return postDoc.data() as Map<String, dynamic>?;
      } else {
        print('Post not found for ID: $postId');
        return null;
      }
    } catch (e) {
      print('Error fetching post: $e');
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  // Like a post (add the userId to the list of likes)
  Future<void> toggleLikePost(PostModel post) async {
    isLoading.value = true;
    try {
      final String userId = _auth.currentUser?.uid.toString() ?? "";

      // Update the local model immediately to avoid lag
      if (post.likes.contains(userId)) {
        post.likes.remove(userId); // Dislike locally
      } else {
        post.likes.add(userId); // Like locally
      }

      update(); // Notify UI of the change instantly

      // Now, handle the Firestore update
      final QuerySnapshot snapshot = await _firestoreUtils.queryDocuments(
        collectionName: posts_collection,
        where: [
          {'field': 'ownerId', 'isEqualTo': post.ownerId},
          {'field': 'createdAt', 'isEqualTo': post.createdAt.toIso8601String()},
        ],
      );

      if (snapshot.docs.isNotEmpty) {
        final postDoc = snapshot.docs.first;

        if (post.likes.contains(userId)) {
          // Like the post in Firestore
          await _firestoreUtils.updateDocument(
            collectionName: posts_collection,
            docId: postDoc.id,
            updates: {
              'likes': FieldValue.arrayUnion([userId])
            },
          );
        } else {
          // Unlike the post in Firestore
          await _firestoreUtils.updateDocument(
            collectionName: posts_collection,
            docId: postDoc.id,
            updates: {
              'likes': FieldValue.arrayRemove([userId])
            },
          );
        }
      } else {
        print('No post found matching the ownerId and createdAt');
      }
    } catch (e) {
      print('Error toggling like: $e');
    } finally {
      isLoading.value = false;
    }
  }

// Get all comments along with user profile info
  Future<List<Map<String, dynamic>>> getAllCommentsWithUserProfile(String ownerId, String createdAt) async {
    try {
      // Find post by ownerId and createdAt
      QuerySnapshot postSnapshot = await _firestoreUtils.getDocumentByQuery(
        collectionName: posts_collection,
        whereConditions: [
          {'field': 'ownerId', 'isEqualTo': ownerId},
          {'field': 'createdAt', 'isEqualTo': createdAt}
        ],
      );

      if (postSnapshot.docs.isNotEmpty) {
        var postDoc = postSnapshot.docs.first;
        List<dynamic> comments = postDoc['comments'];

        // Fetch user profiles for each comment
        List<Map<String, dynamic>> enrichedComments = [];
        for (var comment in comments) {
          String userId = comment['userId'];
          DocumentSnapshot userDoc = await _firestoreUtils.getDocument(collectionName: 'users_collection', docId: userId);

          if (userDoc.exists) {
            comment['userName'] = userDoc['name'];
            comment['userProfileImage'] = userDoc['profileImage'];
          }

          enrichedComments.add(comment);
        }

        return enrichedComments;
      }
    } catch (e) {
      print('Error fetching comments: $e');
    }
    return [];
  }

// Add a comment to a post
  Future<void> addComment(String ownerId, String createdAt, String comment) async {
    isLoading.value = true;
    try {
      Map<String, dynamic> newComment = {
        'commentText': comment,
        'userId': _auth.currentUser?.uid.toString() ?? "",
        'createdAt': DateTime.now().toIso8601String(),
        'replies': [] // Array of reply comments
      };

      // Find post by ownerId and createdAt
      QuerySnapshot postSnapshot = await _firestoreUtils.getDocumentByQuery(
        collectionName: posts_collection,
        whereConditions: [
          {'field': 'ownerId', 'isEqualTo': ownerId},
          {'field': 'createdAt', 'isEqualTo': createdAt}
        ],
      );

      if (postSnapshot.docs.isNotEmpty) {
        var postDoc = postSnapshot.docs.first;

        await _firestoreUtils.updateDocument(
          collectionName: posts_collection,
          docId: postDoc.id,
          updates: {
            'comments': FieldValue.arrayUnion([newComment])
          },
        );
      }
    } catch (e) {
      print('Error adding comment: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Reply to a comment
// Reply to a comment
  Future<void> replyToComment(String ownerId, String createdAt, Map<String, dynamic> parentComment, String replyText) async {
    isLoading.value = true;
    try {
      Map<String, dynamic> newReply = {
        'commentText': replyText,
        'userId': _auth.currentUser?.uid.toString() ?? "",
        'createdAt': DateTime.now().toIso8601String(),
      };

      // Update the replies array of the parent comment
      List<Map<String, dynamic>> updatedReplies = List<Map<String, dynamic>>.from(parentComment['replies']);
      updatedReplies.add(newReply);

      // Find post by ownerId and createdAt
      QuerySnapshot postSnapshot = await _firestoreUtils.getDocumentByQuery(
        collectionName: posts_collection,
        whereConditions: [
          {'field': 'ownerId', 'isEqualTo': ownerId},
          {'field': 'createdAt', 'isEqualTo': createdAt}
        ],
      );

      if (postSnapshot.docs.isNotEmpty) {
        var postDoc = postSnapshot.docs.first;

        // Update the parent comment with the new reply
        await _firestoreUtils.updateDocument(
          collectionName: posts_collection,
          docId: postDoc.id,
          updates: {
            'comments': FieldValue.arrayRemove([parentComment]) // First remove the old comment
          },
        );

        parentComment['replies'] = updatedReplies; // Add replies to the parent comment

        await _firestoreUtils.updateDocument(
          collectionName: posts_collection,
          docId: postDoc.id,
          updates: {
            'comments': FieldValue.arrayUnion([parentComment]) // Add the updated comment with replies
          },
        );
      }
    } catch (e) {
      print('Error replying to comment: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Share a post (add the userId to the list of shares)
  Future<void> sharePost(String postId) async {
    isLoading.value = true;
    try {
      await _firestoreUtils.updateDocument(
        collectionName: posts_collection,
        docId: postId,
        updates: {
          'shares': FieldValue.arrayUnion([_auth.currentUser?.uid.toString() ?? ""])
        },
      );
    } catch (e) {
      print('Error sharing post: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMorePosts() async {
    if (!isLoadingMore.value) {
      isLoadingMore.value = true;

      // Load 5 more posts
      List<Map<String, dynamic>> newPosts = await getAllPosts();
      posts.addAll(newPosts);
      postLoadingLimit += 5;
      isLoadingMore.value = false;
    }
  }
}
