import 'package:en_touch/features/result/data/repo/result_repo_imp;.dart';
import 'package:en_touch/features/result/domain/repo/result_repo.dart';

class ResultUseCase {
  ResultRepo resultRepo = ResultRepoImp();
  Future<void> call() async {
    await resultRepo.getResult();
  }
}