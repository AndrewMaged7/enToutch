
import 'package:en_touch/features/learn%20new%20sign/data/model/save_history_model.dart';

abstract class LearnNewSignRepo {
  Future<SaveHistoryModel> saveHistory(String inputText);
}