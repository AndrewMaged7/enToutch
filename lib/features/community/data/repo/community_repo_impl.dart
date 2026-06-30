import 'package:en_touch/core/services/app_services.dart';
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
import 'package:en_touch/features/community/data/source/community_data_source.dart';
import 'package:en_touch/features/community/data/source/community_data_source_impl.dart';
import 'package:en_touch/features/community/domain/repo/community_repo.dart';

class CommunityRepoImpl extends CommunityRepo {
  AppServices appServices = AppServices();
  CommunityDataSource communityDataSource = CommunityDataSourceImpl();
  @override
  Future<AddCommentModel> addComment({required String postId, required String content}) async {
    try {
      var response = await communityDataSource.addComment(postId: postId, content: content);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return AddCommentModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load conversations: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching conversations: $e');
    }
  }

  @override
  Future<AddLikeModel> addLike({required String postId}) async {
    try {
      var response = await communityDataSource.addLike(postId: postId);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return AddLikeModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load conversations: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching conversations: $e');
    }
  }

  @override
  Future<AddPostModel> addPost({required String content, String? mediaUrl, String? mediaType}) async {
    try {
      var response = await communityDataSource.addPost(content: content, mediaUrl: mediaUrl, mediaType: mediaType);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return AddPostModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load conversations: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching conversations: $e');
    }
  }

  @override
  Future<DeleteModel> deleteComment({required String commentId}) async {
    try {
      var response = await communityDataSource.deleteComment(commentId: commentId);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return DeleteModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load conversations: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching conversations: $e');
    }
  }

  @override
  Future<DeleteModel> deletePost({required String postId}) async {
    try {
      var response = await communityDataSource.deletePost(postId: postId);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return DeleteModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load conversations: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching conversations: $e');
    }
  }

  @override
  Future<List<GetCommentModel>> getComments({required String postId}) async {
     try {
      var response = await communityDataSource.getComments(postId: postId);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        List data = response.data;
        return data.map((e) => GetCommentModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load conversations: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching conversations: $e');
    }
  }

  @override
  Future<List<GetPostModel>> getMyPosts() async {
    try {
      var response = await communityDataSource.getMyPosts();
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        List data = response.data;
        return data.map((e) => GetPostModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load conversations: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching conversations: $e');
    }
  }

  @override
  Future<List<GetPostModel>> getPosts() async {
    try {
      var response = await communityDataSource.getPosts();
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        List data = response.data;
        return data.map((e) => GetPostModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load conversations: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching conversations: $e');
    }
  }
  
  @override
  Future<String?> commentWithRecord() async {
    String? text = await appServices.answerWithRecord();
    return text;
  }

   @override
  Future<TextToSignModel> sendText(String text) async {
    try {
      var response = await communityDataSource.sendText(text);
      if (response!.statusCode! >= 200 && response.statusCode! <= 299) {
        return TextToSignModel.fromJson(response.data);
      } else {
        throw Exception('Failed to send text ${response.statusCode} ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<FriendRequestModel> sendRequest(String userId) async {
    try {
      var response = await communityDataSource.sendRequest(userId);
      if (response == null) {
      throw Exception("No response from server");
    }
      if(response.statusCode! >= 200 && response.statusCode! <= 299){
        return FriendRequestModel.fromJson(response.data);
      }
      else{
        throw Exception("Failed to send friend request ${response.statusCode} ${response.statusMessage}" );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }  


  @override
  Future<List<GetFriendsModel>> getFriends() async {
    try {
      var response = await communityDataSource.getFriends();
      if(response.statusCode! >= 200 && response.statusCode! <= 299){
        List<GetFriendsModel> friends = (response.data as List).map((e) => GetFriendsModel.fromJson(e)).toList();
        return friends;
      }
      throw Exception("Failed to load friends");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<PendingModel>> getPending() async {
    try {
      var response = await communityDataSource.getPending();
      if(response!.statusCode! >= 200 && response.statusCode! <= 299){
        List<PendingModel> pendingRequests = (response.data as List).map((e) => PendingModel.fromJson(e)).toList();
        return pendingRequests;
      }
      throw Exception("Failed to load pending requests");
    } catch (e) {
      throw Exception(e.toString());
    }
  }


}