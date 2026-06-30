import 'package:en_touch/core/api/api_manager.dart';
import 'package:en_touch/core/api/end_points.dart';
import 'package:en_touch/features/community/data/source/community_data_source.dart';
import 'package:dio/dio.dart';

class CommunityDataSourceImpl implements CommunityDataSource {
  ApiManager apiManager = ApiManager();
  EndPoints endPoints = EndPoints();

  @override
  Future<Response> addComment({required String postId, required String content}) async {
    return await apiManager.post(endPoint:"${endPoints.addComment}$postId/comment", data: {"content": content});
  }
  
  @override
  Future<Response> addLike({required String postId}) async {
    return await apiManager.post(endPoint:"${endPoints.addLike}$postId/like");
  }
  
  @override
  Future<Response> addPost({required String content, String? mediaUrl, String? mediaType}) async {
    return await apiManager.post(endPoint:endPoints.addPost, data: {"content": content, "mediaUrl": mediaUrl, "mediaType": mediaType});
  }
  
  @override
  Future<Response> deleteComment({required String commentId}) async {
    return await apiManager.delete(endPoint:"${endPoints.deleteComment}$commentId");
  }
  
  @override
  Future<Response> deletePost({required String postId}) async {
    return await apiManager.delete(endPoint:"${endPoints.deletePost}$postId");
  }
  
  @override
  Future<Response> getComments({required String postId}) async {
    return await apiManager.get(endPoint:"${endPoints.getComments}$postId/comments");
  }
  
  @override
  Future<Response> getMyPosts() async {
    return await apiManager.get(endPoint: endPoints.getMyPosts);
  }
  
  @override
  Future<Response> getPosts() async {
    return await apiManager.get(endPoint: endPoints.getPosts);
  }

  @override
  Future<Response?> sendText(String text) async {
    return await apiManager.post(endPoint: endPoints.saveHistory, data: {"inputText": text});
  }

  @override
  Future<Response?> sendRequest(String userId) async {
    return await apiManager.post(endPoint: "${endPoints.sendRequest}$userId");
  }
  
  @override
  Future<Response<dynamic>> getFriends() async {
    return await apiManager.get(endPoint: endPoints.getFriends);
  }

  @override
  Future<Response<dynamic>?> getPending() async {
    return await apiManager.get(endPoint: endPoints.getPending);
  }

}