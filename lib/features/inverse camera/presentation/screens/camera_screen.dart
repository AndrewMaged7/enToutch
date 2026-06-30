

import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/features/inverse%20camera/presentation/cubit/inverse_camera_cubit.dart';
import 'package:en_touch/features/inverse%20camera/presentation/widgets/camera_widget.dart';
import 'package:en_touch/features/inverse%20camera/presentation/widgets/result_camera_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InverseCameraScreen extends StatelessWidget {
  InverseCameraScreen({super.key});

  final InverseCameraCubit cameraCubit = InverseCameraCubit();

  @override
  Widget build(BuildContext context) {
    final int tapIndex =
        (ModalRoute.of(context)?.settings.arguments as int?) ?? 0;
    cameraCubit.tabIndex = tapIndex;
    return BlocBuilder<InverseCameraCubit, InverseCameraState>(
      bloc: cameraCubit,
      builder: (context, state) {
    
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              Navigator.pushNamed(context, Routes.main);
            }, icon: Icon(Icons.arrow_back_ios_new,color: Theme.of(context).iconTheme.color)),
          ),
          body: cameraCubit.tabIndex == 0
              ? InverseCameraWidget(cameraCubit: cameraCubit)
              : InverseResultWidget(cameraCubit: cameraCubit),
        );
      },
    );
  }
}
