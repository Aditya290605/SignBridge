import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SignDisplayScreen extends StatefulWidget {
  final String word;

  SignDisplayScreen({required this.word});

  @override
  _SignDisplayScreenState createState() => _SignDisplayScreenState();
}

class _SignDisplayScreenState extends State<SignDisplayScreen> {
  VideoPlayerController? _controller;
  String? assetPath;
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  void _loadVideo() async {
    // Map words to sign videos
    Map<String, String> signDictionary = {
      "hello": "assets/sign/hello.mp4",
      "yes": "assets/hello/Yes.gif",
      "no": "assets/hello/No.gif",
      "please": "assets/hello/please.gif",
      "good night": "assets/hello/Good night.jpg",
      "i love you": "assets/hello/i_love_you.webp",
      "nice to meet you": "assets/hello/nice to meet you.gif",
      "are you all right": "assets/hello/are you all right.gif",
    };

    assetPath = signDictionary[widget.word.toLowerCase()];

    if (assetPath != null) {
      _controller = VideoPlayerController.asset(assetPath!)
        ..initialize()
            .then((_) {
              setState(() {
                isLoading = false; // Video loaded successfully
              });

              // **Mute the video**
              _controller!.setVolume(0);

              // **Loop the video**
              _controller!.setLooping(true);

              // **Play the video automatically**
              _controller!.play();
            })
            .catchError((error) {
              print("Error initializing video: $error");
              setState(() {
                isLoading = false; // Stop loading
              });
            });
    } else {
      setState(() {
        isLoading = false; // No video found, stop loading
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Language Display")),
      body: Center(
        child:
            isLoading
                ? CircularProgressIndicator()
                : assetPath != null &&
                    _controller != null &&
                    _controller!.value.isInitialized
                ? AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                )
                : Text(
                  "Sign not found for '${widget.word}'",
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
      ),
    );
  }
}
