import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List <String> sliderImages = [
    'images/slider.png',
    'images/slider_2.png',
    'images/slider_3.png',
  ];
}
