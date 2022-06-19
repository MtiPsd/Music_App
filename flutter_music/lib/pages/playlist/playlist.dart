import 'package:flutter_music/helpers/neumorphic_button.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../Bloc/bloc.dart';
import 'list_all_songs.dart';
import '../home/home_appbar.dart';
import 'build_songs_list.dart';
import '../../helpers/texts_animation.dart';
//****

class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist>
    with SingleTickerProviderStateMixin {
//

  bool isFavoriteSong = false;
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          appbar: PreferredSize(
            child: AppBar(),
            preferredSize: const Size.fromHeight(100),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 10),

//************************** Song Name **************************

            child: StreamBuilder(
              stream: Bloc.audioPlayer.playingStream,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                bool? isPlaying = snapshot.data;

                if (isPlaying != null && isPlaying) {
                  return AnimatedSongText(
                    text: Bloc.currentSongTitle,
                    fontSize: 20,
                  );
                }

                return Text(
                  Bloc.currentSongTitle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.bold,
                    color: Colors.white30,
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            // ignore: missing_required_param
            renderButton(
              icon: Icons.arrow_back,
              iconColor: Colors.grey,
              height: 50,
              width: 50,
              padding: const EdgeInsets.only(right: 40, top: 10),
              onTap: () => Navigator.pop(context),
            ),
          ],
          backgroundColor: NeumorphicTheme.baseColor(context),
          child: const SizedBox(),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),

              // ******************************************** Song Details ********************************************

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //*************************** Favorite  ***************************

                  StreamBuilder(
                    stream: Bloc.audioPlayer.playingStream,
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      bool? isPlaying = snapshot.data;

                      if (isPlaying == null) return const Text("");

                      return StreamBuilder(
                        stream: Bloc.audioPlayer.currentIndexStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<int?> snapshot) {
                          //

                          int? currentSongIndex = snapshot.data;
                          if (currentSongIndex == null) {
                            return const Text("");
                          }

                          int? selectedSongId = Bloc.songs[currentSongIndex].id;

                          if (currentSongIndex ==
                              Bloc.audioPlayer.currentIndex) {
                            Checkbox(
                              value: isFavoriteSong,
                              onChanged: (bool? value) {
                                setState(() {
                                  isFavoriteSong = value!;
                                });

                                if (isFavoriteSong && isPlaying) {
                                } else if (isFavoriteSong == false &&
                                    isPlaying) {
                                  Bloc.audioQuery.removeFromPlaylist(
                                      62157, selectedSongId);
                                }
                              },
                            );
                          }

                          return const Text("");
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 50),

                  //*************************** Song Image  ***************************

                  // ignore: missing_required_param
                  renderButton(
                    width: 120,
                    height: 120,
                    padding: const EdgeInsets.all(0),
                    useButton: false,
                    radiusContainer: 100,
                    robbonThickness: const EdgeInsets.all(5),
                    //
                    child: StreamBuilder<bool>(
                      stream: Bloc.audioPlayer.playingStream,
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        //
                        bool? playingState = snapshot.data;

                        if (playingState != null && playingState) {
                          return QueryArtworkWidget(
                            id: Bloc.songs[Bloc.currentIndex].id,
                            type: ArtworkType.AUDIO,
                            artworkBorder: BorderRadius.circular(200.0),
                            nullArtworkWidget: const Icon(
                              Icons.image_not_supported,
                              size: 60,
                            ),
                          );
                        }

                        return const Text("");
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Expanded(
                //
                // ******************************************** All Songs ********************************************

                child: ListAllSongs(widget: BuildSongList()),
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
      }
    });
  }
}
