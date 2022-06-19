import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../Bloc/bloc.dart';
import '../../helpers/neumorphic_button.dart';
//****

class PlayMusicButton extends StatefulWidget {
  //
  final double robbonThickness;
  final double width;
  final double height;
  final double iconSize;
  const PlayMusicButton({
    Key? key,
    required this.width,
    required this.height,
    required this.robbonThickness,
    required this.iconSize,
  }) : super(key: key);

  @override
  State<PlayMusicButton> createState() => _PlayMusicButtonState();
}

class _PlayMusicButtonState extends State<PlayMusicButton> {
  //

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: Bloc.audioPlayer.playingStream,
      builder: (
        BuildContext context,
        AsyncSnapshot<bool> snapshot,
      ) {
        bool? playingState = snapshot.data;

        if (playingState != null && playingState) {
          // ignore: missing_required_param
          return renderButton(
            width: widget.width,
            height: widget.height,
            padding: const EdgeInsets.all(0),
            icon: Icons.pause,
            iconSize: widget.iconSize,
            robbonThickness: EdgeInsets.all(widget.robbonThickness),
            buttonColor: Colors.black12,
            buttonShape: NeumorphicShape.concave,
            iconColor: Colors.grey,
            onTap: () {
              Bloc.audioPlayer.pause();
            },
          );
        }

        // ignore: missing_required_param
        return renderButton(
          width: widget.width,
          height: widget.height,
          padding: const EdgeInsets.all(0),
          icon: Icons.play_arrow,
          iconSize: widget.iconSize,
          buttonColor: Colors.black12,
          robbonThickness: EdgeInsets.all(widget.robbonThickness),
          iconColor: Colors.grey,
          onTap: () {
            if (Bloc.audioPlayer.currentIndex != null) {
              Bloc.audioPlayer.play();
            }
          },
        );
      },
    );
  }
}
