

import 'package:en_touch/core/services/app_services.dart';

import '../../domain/repo/learn_new_sign_repo.dart';
import '../model/save_history_model.dart';
import '../source/learn_new_sign_data_source.dart';
import '../source/learn_new_sign_data_source_impl.dart';

class LearnNewSignRepoImpl extends LearnNewSignRepo {
  LearnNewSignDataSource learnNewSignDataSource =
      LearnNewSignDataSourceImpl();
  AppServices appServices = AppServices();

  @override
  Future<SaveHistoryModel> saveHistory(String inputText) async {
    var response = await learnNewSignDataSource.saveHistory(inputText);
    if (response!.statusCode! >= 200 && response.statusCode! <= 299) {
      return SaveHistoryModel.fromJson(response.data);
    } else {
      throw Exception('Failed to save history');
    }
  }
  
}