import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../Bloc/bloc.dart';
import 'build_favorite_list.dart';
//****

class ListFavoriteSongs extends StatelessWidget {
  const ListFavoriteSongs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //

    Future<bool> favoritePlaylist = Bloc.audioQuery.createPlaylist("Favorite");

    // Bloc.audioQuery.removePlaylist(62162);

    return FutureBuilder<bool>(
      future: favoritePlaylist,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        //
        bool? isListCreated = snapshot.data;

        if (isListCreated != null && isListCreated) {
          return FutureBuilder(
            future: Bloc.audioQuery.queryPlaylists(
              sortType: PlaylistSortType.DATE_ADDED,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true,
            ),
            builder: (BuildContext context,
                AsyncSnapshot<List<PlaylistModel>> snapshot) {
              if (snapshot.data == null) {
                return const Text("");
              } else if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    "No Playlist Found",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.bold,
                      color: Colors.white30,
                    ),
                  ),
                );
              }

              Bloc.playLists.clear();
              Bloc.playLists = snapshot.data!;

              return const BuildFavoriteList();
            },
          );
        }

        return const Text(
          "Favorite list not created",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Quicksand",
            fontWeight: FontWeight.bold,
            color: Colors.white30,
          ),
        );
      },
    );
  }
}



// 62156