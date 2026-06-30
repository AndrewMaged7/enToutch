import 'package:en_touch/features/inverse%20result/data/source/result_data_source.dart';
import 'package:en_touch/features/inverse%20result/data/source/result_data_source_impl.dart';
import 'package:en_touch/features/inverse%20result/domain/repo/result_repo.dart';

class InverseResultRepoImp extends InverseResultRepo {
  InverseResultDataSource resultDataSource = InverseResultDataSourceImpl();
  @override
  Future<void> getResult() async {
    var response = await resultDataSource.getResult();
    if(response!.statusCode! >= 200 && response.statusCode! <= 299){
    }
  }
}