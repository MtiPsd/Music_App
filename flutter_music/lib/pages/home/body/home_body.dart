import 'package:flutter/material.dart';
import 'package:flutter_music/helpers/neumorphic_button.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';
import '../../../Bloc/bloc.dart';
//*****

class MyBody extends StatefulWidget {
  const MyBody({Key? key}) : super(key: key);

  @override
  State<MyBody> createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Bloc.audioPlayer.playingStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        bool? isPlaying = snapshot.data;

        return Center(
          child: SizedBox(
            child: Lottie.asset(
              "assets/lottie/music_notes.json",
              animate: isPlaying != null && isPlaying ? true : false,
            ),
          ),
        );
      },
    );
  }
}
