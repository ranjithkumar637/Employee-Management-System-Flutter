import 'package:flutter/material.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';

class FullScreenLiveStream extends StatefulWidget {
  final String link;
  const FullScreenLiveStream(this.link, {super.key});

  @override
  State<FullScreenLiveStream> createState() => _FullScreenLiveStreamState();
}

class _FullScreenLiveStreamState extends State<FullScreenLiveStream> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: YoYoPlayer(
        aspectRatio: 16 / 9,
        url:  widget.link,
        videoStyle: const VideoStyle(
          showLiveDirectButton: true,
          fullScreenIconColor: Colors.white,
          qualityStyle: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          forwardAndBackwardBtSize: 30.0,
          playButtonIconSize: 40.0,
          playIcon: Icon(
            Icons.play_arrow,
            size: 40.0, color: Colors.white,
          ),
          pauseIcon: Icon(
            Icons.pause_circle,
            size: 40.0, color: Colors.white,
          ),
          videoQualityPadding: EdgeInsets.all(5.0),
        ),
        videoLoadingStyle: const VideoLoadingStyle(
          loading: Center(
            child: Text("Loading video..."),
          ),
        ),
        allowCacheFile: true,
        onCacheFileCompleted: (files) {
          print('Cached file length ::: ${files?.length}');

          if (files != null && files.isNotEmpty) {
            for (var file in files) {
              print('File path ::: ${file.path}');
            }
          }
        },
        onCacheFileFailed: (error) {
          print('Cache file error ::: $error');
        },
        displayFullScreenAfterInit: true,
        // onFullScreen: (value) {
        //   setState(() {
        //     // if (fullscreen != value) {
        //     //   fullscreen = value;
        //     // }
        //   });
        // }
      ),
    );
  }
}
