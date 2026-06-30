import 'package:en_touch/features/main/cubit/main_cubit.dart';
import 'package:en_touch/features/main/widgets/bottom_nac_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key,});

  final MainCubit mainCubit = MainCubit();
  

  @override
  Widget build(BuildContext context) {
    final int tapIndex =
        (ModalRoute.of(context)?.settings.arguments as int?) ?? 0;
    mainCubit.currentIndex = tapIndex;
    return BlocBuilder<MainCubit, MainState>(
      bloc: mainCubit,
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavBar(mainCubit: mainCubit,),
          body: mainCubit.tabs[mainCubit.currentIndex],
        );
      },
    );
  }
}
