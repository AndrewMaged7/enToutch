import 'package:en_touch/features/learn%20new%20sign/data/model/save_history_model.dart';
import 'package:en_touch/features/learn%20new%20sign/data/repo/learn_new_sign_repo_impl.dart';
import 'package:en_touch/features/learn%20new%20sign/domain/repo/learn_new_sign_repo.dart';

class SaveHistoryUseCase {
  final LearnNewSignRepo learnNewSignRepo = LearnNewSignRepoImpl(); // Initialize the repository

  SaveHistoryUseCase();

  Future<SaveHistoryModel> call(String inputText) async {
    return await learnNewSignRepo.saveHistory(inputText);
  }
}