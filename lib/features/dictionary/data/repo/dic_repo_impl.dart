import 'package:dio/dio.dart';
import 'package:en_touch/core/services/app_services.dart';
import 'package:en_touch/features/dictionary/data/models/dic_model.dart';
import 'package:en_touch/features/dictionary/domain/repo/dic_repo.dart';

class YoutubeService extends DicRepo {
  Dio apiManager = Dio();
  AppServices appServices = AppServices();

  @override
 Future<List<YoutubeVideoModel>> searchVideos(
  String apiKey,
  String query,
) async {
  final url =
      'https://www.googleapis.com/youtube/v3/search'
      '?part=snippet'
      '&q=$query sign language'
      '&type=video'
      '&maxResults=20'
      '&key=$apiKey';

  final response = await apiManager.get(url);

  if (response.statusCode! >= 200 && response.statusCode! < 300) {
    if (response.data == null || response.data['items'] == null) {
      return [];
    }
    final List items = response.data['items'];
    return items.map((item) => YoutubeVideoModel.fromJson(item)).toList();
    
  } else {
    throw Exception(
      'request failed with status: ${response.statusCode} '
      'and message: ${response.statusMessage}',
    );
  }
}

  @override
  Future<String?> translation() async {
    try {
      String? text = await appServices.answerWithRecord();
      return text;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  }


















// import 'package:en_touch/features/dictionary/data/models/dic_model.dart';
// import 'package:en_touch/features/dictionary/data/sources/dic_data_source_impl.dart';
// import 'package:en_touch/features/dictionary/data/sources/dic_datat_source.dart';
// import 'package:en_touch/features/dictionary/domain/repo/dic_repo.dart';

// class DicRepoImpl extends DicRepo {
  
//   DicModel dicModel = DicModel();
//   DicDataSource dicDataSource = DicDataSourceImpl();

//   @override
//   Future<DicModel> getDictionaryData(String inputText) async {
//     var response = await dicDataSource.getDictionaryData(inputText);
//     try{
//       if (response.statusCode! >= 200 && response.statusCode! < 300) {
//       dicModel = DicModel.fromJson(response.data);
//       return dicModel;
//     } else {
//       throw Exception('request failed with status: ${response.statusCode} and message: ${response.statusMessage}');
//     }
//     }catch(e){
//       print(e.toString());
//       throw Exception(response.statusMessage ?? 'An error occurred while fetching dictionary data');
//     }
//   }
  
// }