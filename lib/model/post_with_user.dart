import 'package:wave/model/post/post_model.dart';
import 'package:wave/model/user/user.dart';

class PostWithUser {
  final PostModel post;
  final UserModel user;

  PostWithUser({required this.post, required this.user});
}
