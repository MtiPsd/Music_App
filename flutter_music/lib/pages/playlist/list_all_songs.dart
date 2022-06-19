import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../Bloc/bloc.dart';

//****

class ListAllSongs extends StatelessWidget {
  const ListAllSongs({Key? key, required this.widget}) : super(key: key);

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
        future: Bloc.audioQuery.querySongs(
          sortType: SongSortType.DATE_ADDED,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder:
            (BuildContext context, AsyncSnapshot<List<SongModel>> snapshot) {
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

          Bloc.songs.clear();
          Bloc.songs = snapshot.data!;

          return widget;
        });
  }
}
