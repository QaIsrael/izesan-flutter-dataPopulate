import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:izesan/utils/colors.dart';
import 'package:video_player/video_player.dart';

class VideoSection extends StatelessWidget {
  // final String videoTitle;
  final ChewieController? chewieController;
  final VideoPlayerController? videoPlayerController;

  VideoSection({
    // required this.videoTitle,
    this.chewieController,
    this.videoPlayerController,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: chewieController != null &&
              chewieController!.videoPlayerController.value.isInitialized
              ? ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AspectRatio(
              aspectRatio: videoPlayerController!.value.aspectRatio,
              child: Chewie(
                controller: chewieController!,
              ),
            ),
          )
              : const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
              strokeWidth: 1,
            ),
          ),
        );
      },
    );
  }
}
