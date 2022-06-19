import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../../Bloc/bloc.dart';
import '../../../../helpers/neumorphic_button.dart';
//****

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    // ignore: missing_required_param
    return renderButton(
      height: 200,
      width: 350,
      padding: const EdgeInsets.all(25),
      useButton: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //****************** Heart Icon ******************

          // ignore: missing_required_param
          renderButton(
            width: 50,
            height: 50,
            padding: const EdgeInsets.only(left: 40, top: 30),
            iconColor: const Color.fromARGB(255, 161, 65, 58),
            icon: Icons.favorite,
            iconSize: 23,
            onTap: () {
              Navigator.pushNamed(context, "favoriteListPage");
            },
          ),

          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 25),

                //****************** Favorites Text ******************

                child: Text(
                  "Favorites",
                  style: TextStyle(
                    fontSize: 25,
                    letterSpacing: 2,
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.bold,
                    color: Colors.white30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Column(
                  children: <Widget>[
                    //****************** Counter Text ******************

                    const SizedBox(height: 5),
                    getItemCount(),
                    //****************** Songs Text ******************

                    const Text(
                      "Songs",
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.bold,
                        color: Colors.white30,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget getItemCount() {
    return FutureBuilder(
      future: Bloc.audioQuery.queryAudiosFrom(AudiosFromType.PLAYLIST, 62161),
      builder: (BuildContext context, AsyncSnapshot<List<SongModel>> snapshot) {
        List<SongModel>? favoritePlaylist = snapshot.data;

        if (favoritePlaylist != null) {
          return itemCount(listLength: favoritePlaylist.length);
        }

        return itemCount(listLength: 0);
      },
    );
  }

  Widget itemCount({required int listLength}) {
    return Text(
      listLength.toString(),
      style: const TextStyle(
        fontSize: 25,
        letterSpacing: 2,
        fontFamily: "Quicksand",
        fontWeight: FontWeight.bold,
        color: Colors.white30,
      ),
    );
  }
}
