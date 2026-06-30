import 'package:en_touch/core/routes/routes.dart';
import 'package:en_touch/features/camera/presentation/cubit/camera_cubit.dart';
import 'package:en_touch/features/camera/presentation/widgets/camera_widget.dart';
import 'package:en_touch/features/camera/presentation/widgets/result_camera_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraScreen extends StatelessWidget {
  CameraScreen({super.key});

  final CameraCubit cameraCubit = CameraCubit();

  @override
  Widget build(BuildContext context) {
    final int tapIndex =
        (ModalRoute.of(context)?.settings.arguments as int?) ?? 0;
    cameraCubit.tabIndex = tapIndex;
    return BlocBuilder<CameraCubit, CameraState>(
      bloc: cameraCubit,
      builder: (context, state) {
    
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              Navigator.pushNamed(context, Routes.main);
            }, icon: Icon(Icons.arrow_back_ios_new,color: Theme.of(context).iconTheme.color)),
          ),
          body: cameraCubit.tabIndex == 0
              ? CameraWidget(cameraCubit: cameraCubit)
              : ResultWidget(cameraCubit: cameraCubit),
        );
      },
    );
  }
}
