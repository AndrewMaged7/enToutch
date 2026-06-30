import 'package:en_touch/features/inverse%20result/data/repo/result_repo_imp;.dart';
import 'package:en_touch/features/inverse%20result/domain/repo/result_repo.dart';

class InverseResultUseCase {
  InverseResultRepo resultRepo = InverseResultRepoImp();
  Future<void> call() async {
    await resultRepo.getResult();
  }
}