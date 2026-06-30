
import 'package:dio/dio.dart';

abstract class CommunityDataSource {
  Future<Response> addPost({required String content,String? mediaUrl,String? mediaType});
  Future<Response> addLike({required String postId});
  Future<Response> addComment({required String postId, required String content});
  Future<Response> getPosts();
  Future<Response> getMyPosts();
  Future<Response> getComments({required String postId});
  Future<Response> deletePost({required String postId});
  Future<Response> deleteComment({required String commentId});
  Future<Response?> sendText(String text);
  Future<Response?> sendRequest(String userId);
  Future<Response> getFriends();
  Future<Response?> getPending();
}