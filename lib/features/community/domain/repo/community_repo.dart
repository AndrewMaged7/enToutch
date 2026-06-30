import 'package:en_touch/features/community/data/models/add_comment_model.dart';
import 'package:en_touch/features/community/data/models/add_friend_model.dart';
import 'package:en_touch/features/community/data/models/add_like_model.dart';
import 'package:en_touch/features/community/data/models/add_post_model.dart';
import 'package:en_touch/features/community/data/models/delete_model.dart';
import 'package:en_touch/features/community/data/models/get_comment_model.dart';
import 'package:en_touch/features/community/data/models/get_post_model.dart';
import 'package:en_touch/features/community/data/models/my_friends_model.dart';
import 'package:en_touch/features/community/data/models/pending_model.dart';
import 'package:en_touch/features/community/data/models/text_to_sign_model.dart';
abstract class CommunityRepo {
  Future<AddPostModel> addPost({required String content,String? mediaUrl,String? mediaType});
  Future<AddLikeModel> addLike({required String postId});
  Future<AddCommentModel> addComment({required String postId, required String content});
  Future<List<GetPostModel>> getPosts();
  Future<List<GetPostModel>> getMyPosts();
  Future<List<GetCommentModel>> getComments({required String postId});
  Future<DeleteModel> deletePost({required String postId});
  Future<DeleteModel> deleteComment({required String commentId});
  Future<String?> commentWithRecord();
  Future<TextToSignModel> sendText(String text);
  Future<FriendRequestModel> sendRequest(String userId);
  Future<List<GetFriendsModel>> getFriends();
  Future<List<PendingModel>> getPending();
}