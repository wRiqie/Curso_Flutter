import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatelessWidget {
  final String videoId;

  VideoPlayer(this.videoId);

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _playerController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(autoPlay: true, mute: false));

    return SafeArea(
      child:
          YoutubePlayer(
            controller: _playerController,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.redAccent,
            progressColors: ProgressBarColors(
              playedColor: Colors.redAccent,
              handleColor: Colors.redAccent,
            ),)
    );
  }
}
