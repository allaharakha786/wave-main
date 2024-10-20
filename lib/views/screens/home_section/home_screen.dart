import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wave/controllers/getx_controllers/post_controller.dart';
import 'package:wave/controllers/services/firebase_service.dart';
import 'package:wave/controllers/utils/app_colors.dart';
import 'package:wave/controllers/utils/app_text_styles.dart';
import 'package:wave/model/post_with_user.dart';
import 'package:wave/views/custom_widgets/custom_widgets.dart';
import 'package:wave/views/screens/create_post_section/create_post_screen.dart';
import 'package:wave/views/screens/home_section/comments_screen.dart';
import 'package:wave/views/screens/home_section/share_screen.dart';
import 'package:wave/views/screens/profile_section/profile_screen.dart';
import '../../../controllers/utils/common_methods.dart';
import '../../../model/post/post_model.dart';
import '../../../model/user/user.dart';
import 'like_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PostController postController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    postController = Get.put(PostController());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        postController.loadMorePosts();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.only(left: 2.4.h, right: 2.4.h, top: 2.4.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => ProfileScreen());
                          },
                          child: Container(
                            width: 6.h,
                            height: 6.h,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primaryColor, width: 2),
                              color: AppColors.hintColor,
                              image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/pngs/profile.jpg",
                                  ),
                                  fit: BoxFit.cover),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(bottom: 3, right: 0, child: SizedBox(height: 2.h, width: 2.h, child: SvgPicture.asset("assets/svgs/flag.svg")))
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    Container(
                        height: 5.h,
                        width: 5.h,
                        decoration: BoxDecoration(color: AppColors.whiteColor, shape: BoxShape.circle, boxShadow: [BoxShadow(color: const Color(0xff000014).withOpacity(0.14), blurRadius: 8, spreadRadius: 0, offset: const Offset(1, 1))]),
                        child: SvgPicture.asset(
                          "assets/svgs/notificationicon.svg",
                          fit: BoxFit.scaleDown,
                        )),
                    getHorizentalSpace(width: .9.h),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const CreatePostScreen());
                      },
                      child: Container(
                        height: 5.h,
                        width: 5.h,
                        decoration: BoxDecoration(color: AppColors.whiteColor, shape: BoxShape.circle, boxShadow: [BoxShadow(color: const Color(0xff000014).withOpacity(0.14), blurRadius: 8, spreadRadius: 0, offset: const Offset(1, 1))]),
                        child: SvgPicture.asset(
                          "assets/svgs/plus.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
                getVerticalSpace(height: 1.h),
                Expanded(
                  child: StreamBuilder<List<PostWithUser>>(
                    stream: postController.getPostsStream(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 250,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.px),
                              ),
                            ),
                          ),
                        );
                      } else {
                        List<PostWithUser> postWithUserItem = snapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemCount: postWithUserItem.length + (postController.isLoadingMore.value ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == postWithUserItem.length) {
                              return const Center(child: CircularProgressIndicator());
                            }

                            PostModel post = postWithUserItem[index].post;
                            UserModel user = postWithUserItem[index].user;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 4.5.h,
                                          height: 4.5.h,
                                          decoration: BoxDecoration(
                                            color: AppColors.hintColor,
                                            image: DecorationImage(
                                              image: NetworkImage(user.profileImage),
                                              fit: BoxFit.cover,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        // Positioned(
                                        //   bottom: 3,
                                        //   right: 0,
                                        //   child: SizedBox(
                                        //     height: 2.h,
                                        //     width: 2.h,
                                        //     child: SvgPicture.asset("assets/svgs/flag.svg"),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    getHorizentalSpace(width: 1.h),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.name,
                                          style: AppTextStyles.regularLargeTextStyle,
                                        ),
                                        Row(
                                          children: [
                                            Text(user.userMetadata?.country.toString() ?? ""),
                                            SvgPicture.asset("assets/svgs/exghangearrows.svg"),
                                            Text(user.userMetadata?.language.toString() ?? ""),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer(), // Use Spacer instead of Expanded to avoid layout issues
                                    Text(
                                      timeAgo(post.createdAt),
                                      style: AppTextStyles.regularLargeTextStyle,
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 5.px),
                                  width: MediaQuery.of(context).size.width,
                                  // Ensure it takes full width
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30.px),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30.px), // Apply the same border radius
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: post.postImage,
                                      placeholder: (context, url) => Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          height: 30.h, // Keep the height the same
                                          color: Colors.grey[300], // Placeholder color
                                        ),
                                      ),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                if (post.postText != "")
                                  Text(
                                    post.postText,
                                    style: AppTextStyles.regularTextStyle,
                                  ),
                                getVerticalSpace(height: 10.px),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                postController.toggleLikePost(post); // Toggle like/dislike
                                              },
                                              child: SvgPicture.asset(post.likes.contains(FirebaseService.auth.currentUser?.uid.toString()) ? "assets/svgs/liked.svg" : "assets/svgs/like.svg"),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  Get.to(() => LikesScreen());
                                                },
                                                child: Text(post.likes.isEmpty ? "" : post.likes.length.toString())),
                                            getHorizentalSpace(width: 1.5.h),
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(() => CommentScreen());
                                              },
                                              child: SvgPicture.asset(post.comments.any((comment) => comment.userId == FirebaseService.auth.currentUser?.uid.toString()) ? "assets/svgs/commented.svg" : "assets/svgs/comment.svg"),
                                            ),
                                            Text(post.comments.isEmpty ? "" : post.comments.length.toString()),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset("assets/svgs/logo.svg"),
                                            getHorizentalSpace(width: 4.h),
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(() => ShareScreen());
                                              },
                                              child: SvgPicture.asset("assets/svgs/sharepost.svg"),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    getVerticalSpace(height: 1.h),
                                    Row(
                                      children: [
                                        Container(
                                          width: 3.h,
                                          height: 3.h,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: AppColors.primaryColor, width: 1),
                                            color: AppColors.hintColor,
                                            image: const DecorationImage(
                                              image: AssetImage("assets/pngs/profile.jpg"),
                                              fit: BoxFit.cover,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        getHorizentalSpace(width: 1.h),
                                        Text(
                                          " Add a comment...",
                                          style: AppTextStyles.regularLargeTextStyle,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                getVerticalSpace(height: 4.h),
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
