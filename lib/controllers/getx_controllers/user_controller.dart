import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:wave/controllers/utils/snackbar.dart';
import 'package:wave/model/user/user.dart';
import 'package:wave/views/screens/auth_section/sign_in_screen.dart';
import '../utils/firestore_utils.dart';
import '../utils/constants.dart';

class UserController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreUtils _firestoreUtils = FirestoreUtils();

  // RxBool loaders for managing loading states
  var loading = false.obs;
  var profileLoading = false.obs;
  RxBool isLoading = false.obs;

  var userData = Rx<UserModel?>(null);

  Future<User?> signUpWithEmail(String name, String email, String password) async {
    loading.value = true; // Set loading state to true

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await _firestoreUtils.setDocument(
          collectionName: users_collection,
          docId: user.uid,
          data: {
            'uid': user.uid,
            'email': email,
            'name': name,
            'password': password,
            'profilePicture': '',
            'createdAt': DateTime.now().toIso8601String(),
            'metaDataAdded': false,
          },
        );
      }
      return user;
    } catch (e) {
      showErrorSnackbar("Error during sign up: $e");
      print('Error during signup: $e');
      return null;
    } finally {
      loading.value = false; // Reset loading state
    }
  }

  Future<Either<bool, User?>> loginWithEmail(String email, String password) async {
    loading.value = true; // Set loading state to true

    print('Starting loginWithEmail for email: $email');

    try {
      // Attempt to sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User sign-in successful for email: $email');

      User? user = userCredential.user;

      if (user != null) {
        print('User retrieved: ${user.uid}');

        // Get the document snapshot from Firestore
        DocumentSnapshot userDoc = await _firestoreUtils.getDocument(
          collectionName: 'users',
          docId: user.uid,
        );
        print('User document fetched from Firestore for userId: ${user.uid}');

        if (userDoc.exists) {
          print('User document exists for userId: ${user.uid}');

          Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

          if (userData != null) {
            bool metaDataAdded = userData['metaDataAdded'] ?? false;
            print('MetaDataAdded: $metaDataAdded for userId: ${user.uid}');

            if (metaDataAdded) {
              print('Returning user with metaDataAdded for userId: ${user.uid}');
              return right(user);
            } else {
              print('MetaData not added for userId: ${user.uid}');
              return left(false);
            }
          } else {
            print('User data is null for userId: ${user.uid}');
          }
        } else {
          print('No document found for userId: ${user.uid}');
          showErrorSnackbar("User with email $email not found");
          return right(null);
        }
      } else {
        print('No user found after sign-in attempt for email: $email');
      }

      return right(null);
    } catch (e) {
      print('Error during login attempt for email: $email, Error: $e');
      showErrorSnackbar("Error during login: $e");
      return left(false);
    } finally {
      print('Login process finished for email: $email');
      loading.value = false; // Reset loading state
    }
  }

  Future<bool> addUserMetadata(String uid, Map<String, dynamic> metadata) async {
    loading.value = true; // Set loading state to true

    try {
      // Check if the user document exists
      final DocumentSnapshot userDoc = await _firestoreUtils.getDocument(
        collectionName: users_collection,
        docId: uid,
      );

      if (userDoc.exists) {
        // User exists, proceed to update metadata
        await _firestoreUtils.updateDocument(
          collectionName: users_collection,
          docId: uid,
          updates: {
            'metaData': metadata,
            'metaDataAdded': true,
          },
        );
        return true;
      } else {
        showErrorSnackbar('User not found');
        return false;
      }
    } catch (e) {
      showErrorSnackbar('Error adding user metadata: $e');
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
      return false;
    } finally {
      loading.value = false; // Reset loading state
    }
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    loading.value = true; // Set loading state to true
    bool emailSent = false;
    try {
      // Check if the email exists in the database
      final userExists = await FirestoreUtils().checkFieldValueInAllDocs(
        collectionName: users_collection,
        fieldName: "email",
        fieldValue: email,
      );

      if (userExists) {
        return await _auth.sendPasswordResetEmail(email: email).then((value) {
          showSuccessSnackbar("Email link sent to $email");
          return true;
        }).catchError((e) {
          showErrorSnackbar("Error sending Email: ${e.toString()}");
          return false;
        });
      } else {
        showErrorSnackbar("User with email $email not found");
        return false;
      }
    } on FirebaseAuthException catch (e) {
      showErrorSnackbar(e.toString());
      return false;
    } finally {
      loading.value = false;
    }
  }

  Future<void> logout() async {
    loading.value = true;
    await _auth.signOut();
    Get.offAll(() => const SignInScreen());
  }

  Future<void> fetchUserProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      profileLoading.value = true;
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

      if (snapshot.exists && snapshot.data() != null) {
        userData.value = UserModel.fromMap(snapshot.data()!);
        print('data printed');
        profileLoading.value = false;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      profileLoading.value = false;
    }
  }

  Future<bool> updateData(String collectionName, String docId, Map<String, dynamic> updatedData) async {
    isLoading.value = true;

    try {
      // Log the data that will be sent to Firestore

      // Create the post in Firestore
      await _firestoreUtils.updateDocument(collectionName: collectionName, docId: docId, updates: updatedData);

      showSuccessSnackbar("Data updated successfully."); // This should work if context is correct.
      isLoading.value = false;
      return true;
    } catch (e) {
      showErrorSnackbar('Error while updating data: $e');
      print('Error creating post: $e');
      isLoading.value = false;
      return false;
    }
  }
}
