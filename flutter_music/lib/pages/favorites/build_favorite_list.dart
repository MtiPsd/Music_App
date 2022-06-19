import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../Bloc/bloc.dart';
import 'single_favorite_song.dart';
//****

class BuildFavoriteList extends StatelessWidget {
  const BuildFavoriteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Variables

    PlaylistModel favoritePlaylist = Bloc.playLists[0];

    Future<List<SongModel>> favoriteFutureSongs = Bloc.audioQuery
        .queryAudiosFrom(AudiosFromType.PLAYLIST, favoritePlaylist.id);

//

    return FutureBuilder(
      future: favoriteFutureSongs,
      builder: (BuildContext context, AsyncSnapshot<List<SongModel>> snapshot) {
        if (snapshot.data == null) {
          return const Text("");
        } else if (snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              "No Music Found",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Quicksand",
                fontWeight: FontWeight.bold,
                color: Colors.white30,
              ),
            ),
          );
        }

        Bloc.favoriteSongs.clear();
        Bloc.favoriteSongs = snapshot.data!;

        return ListView.builder(
          itemCount: Bloc.favoriteSongs.length,
          cacheExtent: 200,
          addAutomaticKeepAlives: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return SingleFavoriteSong(index);
          },
        );
      },
    );
  }
}
