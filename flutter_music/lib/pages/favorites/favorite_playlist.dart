import 'package:flutter_music/helpers/neumorphic_button.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../Bloc/bloc.dart';
import '../home/home_appbar.dart';
import 'list_favorite_songs.dart';
//****

class FavoritePlaylist extends StatefulWidget {
  const FavoritePlaylist({Key? key}) : super(key: key);

  @override
  State<FavoritePlaylist> createState() => _FavoritePlaylistState();
}

class _FavoritePlaylistState extends State<FavoritePlaylist>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Bloc.player.currentIndexStream.listen((int? index) {
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
          title: const Padding(
            padding: EdgeInsets.only(top: 10),

//************************** Song Name **************************

            child: Text(
              "Favorite Songs",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Quicksand",
                fontWeight: FontWeight.bold,
                color: Colors.white30,
              ),
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
            children: const <Widget>[
              Expanded(
                //
                // ******************************************** Favorite Songs ********************************************

                child: ListFavoriteSongs(),
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
