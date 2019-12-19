import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final String videoid;
  VideoPlayer({this.videoid});
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    try {
      _controller = YoutubePlayerController(
        initialVideoId: widget.videoid,
        flags: YoutubePlayerFlags(
          disableDragSeek: true,
          mute: false,
          autoPlay: false,
          forceHideAnnotation: true,
        ),
      );
    } on NetworkImageLoadException {
      print('Networkimageexception');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.amber,
      progressColors: ProgressBarColors(backgroundColor: Colors.cyan),
      onReady: () {
        print('Player is ready.');
      },
    );
  }
}
