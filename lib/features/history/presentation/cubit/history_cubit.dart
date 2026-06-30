import 'package:bloc/bloc.dart';
import 'package:en_touch/features/history/data/model/get_histort_model.dart';
import 'package:en_touch/features/history/domain/use_case/get_history_use_case.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {

 GetHistoryUseCase getHistoryUseCase = GetHistoryUseCase();

  HistoryCubit() : super(HistoryInitial());
  List<GetHistoryModel> model = [];

  Future<void> getHistory() async {
    emit(HistoryLoading());
      try {
        model = await getHistoryUseCase.call() ?? [];
        emit(HistorySuccess());
      } catch (e) {
        emit(HistoryError(e.toString()));
      }
  }
}
