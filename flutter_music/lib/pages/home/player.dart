import 'package:flutter_music/helpers/neumorphic_button.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart';
import '../../Bloc/bloc.dart';
import '../../helpers/texts_animation.dart';
import 'player_play_button.dart';
//****

class Player extends StatefulWidget {
  //

  const Player({Key? key}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
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

  Stream<DurationState> get _durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
        Bloc.audioPlayer.positionStream,
        Bloc.audioPlayer.durationStream,
        (Duration position, Duration? duration) => DurationState(
          position: position,
          duration: duration ?? Duration.zero,
        ),
      );
  //
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          // ******************************************** Pop *****************************************************************************

          children: <Widget>[
            Container(
              height: 70,
              color: Colors.transparent,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Icon(
                    Icons.arrow_drop_down,
                    size: 50,
                    color: Color.fromARGB(77, 103, 103, 103),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ******************************************** Song Details *****************************************************************************

            //*************************** Song Image ***************************

            // ignore: missing_required_param
            renderButton(
              width: 240,
              height: 240,
              padding: const EdgeInsets.all(0),
              useButton: false,
              radiusContainer: 200,
              robbonThickness: const EdgeInsets.all(15),
              child: Bloc.audioPlayer.playing
                  ? QueryArtworkWidget(
                      id: Bloc.songs[Bloc.currentIndex].id,
                      type: ArtworkType.AUDIO,
                      artworkWidth: double.infinity,
                      artworkFit: BoxFit.cover,
                      artworkBorder: BorderRadius.circular(200.0),
                      nullArtworkWidget: const Icon(
                        Icons.image_not_supported,
                        size: 100,
                      ),
                    )
                  : const Text(""),
            ),
            const SizedBox(height: 40),

            //*************************** Song Name ***************************

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: StreamBuilder(
                stream: Bloc.audioPlayer.playingStream,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  bool? isPlaying = snapshot.data;

                  if (isPlaying != null && isPlaying) {
                    return AnimatedSongText(
                      text: Bloc.currentSongTitle,
                      fontSize: 17,
                    );
                  }

                  return Text(
                    Bloc.currentSongTitle,
                    style: const TextStyle(
                      fontSize: 17,
                      letterSpacing: 0.5,
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.bold,
                      color: Colors.white30,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            //*************************** Song Artist ***************************

            Text(
              Bloc.audioPlayer.playing ? Bloc.currentSongArtist : "Song Artist",
              style: const TextStyle(
                fontSize: 13,
                letterSpacing: 0.5,
                fontFamily: "Quicksand",
                color: Colors.white30,
              ),
            ),
          ],
        ),

        // **************  Player Controllers **************

        bottomNavigationBar: SizedBox(
          height: 200,
          child: StreamBuilder<DurationState>(
            stream: _durationStateStream,
            builder: (
              BuildContext context,
              AsyncSnapshot<DurationState> snapshot,
            ) {
              final durationState = snapshot.data;

              final progress = durationState?.position ?? Duration.zero;

              final total = durationState?.duration ?? Duration.zero;

              return Column(
                children: <Widget>[
                  //

                  // ******************************************** Slider *****************************************************************************

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 15,
                        inactiveTrackColor: Colors.white10,
                        activeTrackColor: Colors.white30,
                        thumbShape: SliderComponentShape.noThumb,
                      ),
                      child: Slider(
                        min: 0,
                        max: total.inSeconds.toDouble(),
                        value: progress.inSeconds.toDouble(),
                        onChanged: (double value) async {
                          final position = Duration(seconds: value.toInt());
                          await Bloc.audioPlayer.seek(position);
                        },
                      ),
                    ),
                  ),

                  // ******************************************** Song Time *****************************************************************************

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //*************************** Start ***************************

                        Text(
                          _printDuration(progress),
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: "Quicksand",
                            color: Colors.white30,
                          ),
                        ),

                        //*************************** End ***************************

                        Text(
                          _printDuration(total),
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: "Quicksand",
                            color: Colors.white30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // ******************************************** Song Play Buttons ********************************************

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //
                      //*************************** Skip Prev ***************************

                      // ignore: missing_required_param
                      renderButton(
                          width: 50,
                          height: 50,
                          padding: const EdgeInsets.only(right: 40),
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

                      //*************************** Play ***************************

                      // ignore: prefer_const_constructors
                      PlayMusicButton(
                        height: 85,
                        width: 85,
                        robbonThickness: 7,
                        iconSize: 30,
                      ),

                      //*************************** Skip Next ***************************

                      // ignore: missing_required_param
                      renderButton(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.only(left: 40),
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
                ],
              );
            },
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
      }
    });
  }

  // Duration Formatter
  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}

class DurationState {
  DurationState({this.duration = Duration.zero, this.position = Duration.zero});

  Duration position, duration;
}
