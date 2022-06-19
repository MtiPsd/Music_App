import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../Bloc/bloc.dart';
import '../../helpers/neumorphic_button.dart';
import '../../helpers/texts_animation.dart';
import 'player_play_button.dart';
//****

class PlayerHeader extends StatefulWidget {
  const PlayerHeader({Key? key}) : super(key: key);

  @override
  State<PlayerHeader> createState() => _PlayerHeaderState();
}

class _PlayerHeaderState extends State<PlayerHeader> {
  //

  @override
  void initState() {
    super.initState();
    Bloc.audioPlayer.currentIndexStream.listen((int? index) {
      if (index != null) {
        updateCurrentPlayingSongDetails(index);
      }
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: Neumorphic(
        style: NeumorphicStyle(
          depth: 1,
          lightSource: LightSource.topLeft,
          intensity: 0.4,
          shadowDarkColor: Colors.black,
          boxShape: NeumorphicBoxShape.roundRect(
            const BorderRadius.vertical(
              top: Radius.circular(100),
            ),
          ),
          shape: NeumorphicShape.convex,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ******************************************** Song Details *****************************************************************************

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //*************************** Song Name ***************************

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                      ),
                      child: StreamBuilder(
                        stream: Bloc.audioPlayer.playingStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<bool> snapshot) {
                          bool? isPlaying = snapshot.data;

                          if (isPlaying != null && isPlaying) {
                            return AnimatedSongText(
                              text: Bloc.currentSongTitle,
                              fontSize: 11,
                            );
                          }

                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              Bloc.currentSongTitle,
                              style: const TextStyle(
                                fontSize: 11,
                                fontFamily: "Quicksand",
                                fontWeight: FontWeight.bold,
                                color: Colors.white30,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 3),
                  ],
                ),
              ),

              // ******************************************** Song Play Buttons *****************************************************************************

              Expanded(
                child: Row(
                  children: <Widget>[
                    //
                    //*************************** Skip Prev ***************************

                    // ignore: missing_required_param
                    renderButton(
                        width: 35,
                        height: 35,
                        padding: const EdgeInsets.only(right: 10),
                        iconColor: Colors.grey,
                        iconSize: 20,
                        icon: Icons.skip_previous,
                        robbonThickness: const EdgeInsets.all(2),
                        onTap: () {
                          if (Bloc.audioPlayer.hasPrevious) {
                            Bloc.audioPlayer.seekToPrevious();
                            Bloc.audioPlayer.play();
                          }
                        }),

                    //*************************** Play  ***************************

                    const PlayMusicButton(
                      height: 47,
                      width: 47,
                      robbonThickness: 6,
                      iconSize: 20,
                    ),

                    //*************************** Skip Next ***************************

                    // ignore: missing_required_param
                    renderButton(
                      width: 35,
                      height: 35,
                      padding: const EdgeInsets.only(left: 10),
                      iconColor: Colors.grey,
                      iconSize: 20,
                      icon: Icons.skip_next,
                      robbonThickness: const EdgeInsets.all(2),
                      onTap: () {
                        if (Bloc.audioPlayer.hasNext) {
                          Bloc.audioPlayer.seekToNext();
                          Bloc.audioPlayer.play();
                        }
                      },
                    ),

                    //
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Update Playing Songs Details
  void updateCurrentPlayingSongDetails(int index) {
    setState(() {
      if (Bloc.songs.isNotEmpty) {
        Bloc.currentSongTitle = Bloc.songs[index].title;
        Bloc.currentIndex = index;
        Bloc.currentSongArtist = Bloc.songs[index].artist ?? "Song Artist";
        Bloc.currentSongName = Bloc.songs[index].displayName;
      }
    });
  }
}
