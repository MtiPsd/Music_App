import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../Bloc/bloc.dart';
import './single_song.dart';
//****

class BuildSongList extends StatefulWidget {
//
  const BuildSongList({Key? key}) : super(key: key);

  @override
  State<BuildSongList> createState() => _BuildSongListState();
}

class _BuildSongListState extends State<BuildSongList> {
//

  @override
  Widget build(BuildContext context) {
//

    return ListView.builder(
      itemCount: Bloc.songs.length,
      cacheExtent: 200,
      addAutomaticKeepAlives: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return SingleSong(index);
      },
    );
  }
}
