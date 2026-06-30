import 'dart:async';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;

  const VideoPlayerScreen({
    super.key,
    required this.videoId,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController controller;
  Timer? _timer;

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
    _startPositionListener();
  }

  void _startPositionListener() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      final duration = await controller.duration;
      final position = await controller.currentTime;
      if (duration > 60 && position >= 60) {
        controller.pauseVideo();
        controller.seekTo(seconds: 0, allowSeekAhead: true);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: YoutubePlayer(
        controller: controller,
      ),
    );
  }
}