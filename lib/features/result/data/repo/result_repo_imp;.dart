import 'package:en_touch/features/result/data/source/result_data_source.dart';
import 'package:en_touch/features/result/data/source/result_data_source_impl.dart';
import 'package:en_touch/features/result/domain/repo/result_repo.dart';

class ResultRepoImp extends ResultRepo {
  ResultDataSource resultDataSource = ResultDataSourceImpl();
  @override
  Future<void> getResult() async {
    var response = await resultDataSource.getResult();
    if(response!.statusCode! >= 200 && response.statusCode! <= 299){
    }
  }
}