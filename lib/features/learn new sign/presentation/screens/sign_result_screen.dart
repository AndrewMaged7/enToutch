import 'package:en_touch/features/learn%20new%20sign/presentation/cubit/learn_new_sign_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SignResultScreen extends StatefulWidget {
  final String videoId;
  final String text;
  final int index;
  final LearnNewSignCubit learnNewSignCubit;

  SignResultScreen({super.key, required this.videoId, required this.text, required this.index, required this.learnNewSignCubit});

  @override
  State<SignResultScreen> createState() => _SignResultScreenState();
}

class _SignResultScreenState extends State<SignResultScreen> {
  late YoutubePlayerController controller;
  @override
  void initState() {
    super.initState();

    controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    controller.loadVideoById(videoId: widget.videoId);
    widget.learnNewSignCubit.loadSavedItems();
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: BlocBuilder<LearnNewSignCubit, LearnNewSignState>(
        bloc: widget.learnNewSignCubit,
        builder: (context, state) {
          if (state is SaveHistoryLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SaveHistoryError) {
            return Center(child: Text(state.error));
          }
          return Column(
            children: [
              YoutubePlayer(controller: controller),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(30.r),
                    child: Text(
                      widget.text,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      widget.learnNewSignCubit.saveHistory(widget.text, widget.index);
                    },
                    child: widget.learnNewSignCubit.savedItems[widget.index] 
                        ? Image.asset(
                            "images/fill_heart_icon.png",
                            height: 27.h,
                            width: 22.w,
                            fit: BoxFit.contain,
                          )
                        : Image.asset(
                            "images/heart_icon.png",
                            height: 27.h,
                            width: 22.w,
                            fit: BoxFit.contain,
                          ),
                  ),
                  SizedBox(width: 30.w),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
