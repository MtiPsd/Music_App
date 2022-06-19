import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../Bloc/bloc.dart';
import '../../helpers/bars_animation.dart';
//****

class FavoriteSlidable extends StatelessWidget {
  const FavoriteSlidable(
      {Key? key,
      required this.selectedSongId,
      required this.index,
      required this.currentIndex,
      required this.animation1,
      required this.animation2,
      required this.animation3})
      : super(key: key);

  final int? index;
  final int? currentIndex;
  final int? selectedSongId;
  final Animation<double> animation1;
  final Animation<double> animation2;
  final Animation<double> animation3;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(index),
      startActionPane: ActionPane(
        key: ValueKey(index),
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          key: ValueKey(index),
          onDismissed: () {
            Bloc.audioQuery.removeFromPlaylist(62162, selectedSongId!);
            Bloc.favoriteSongs.removeAt(index!);
          },
        ),
        extentRatio: 0.01,
        children: <Widget>[
          SlidableAction(
            onPressed: (BuildContext context) {},
            backgroundColor: NeumorphicTheme.baseColor(context),
            foregroundColor: Colors.white30,
            icon: Icons.delete,
            autoClose: true,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        title: Text(
          Bloc.favoriteSongs[index!].displayName,
          style: TextStyle(
            fontSize: 15,
            fontFamily: "Quicksand",
            fontWeight: FontWeight.bold,
            color: currentIndex == currentIndex && currentIndex != null
                ? const Color.fromARGB(255, 176, 136, 14)
                : Colors.white30,
          ),
        ),
        subtitle: Text(
          Bloc.favoriteSongs[index!].artist ?? "unknown",
          style: TextStyle(
            fontSize: 12,
            fontFamily: "Quicksand",
            color: currentIndex == currentIndex && currentIndex != null
                ? const Color.fromARGB(255, 176, 136, 14)
                : Colors.white30,
          ),
        ),
        trailing: currentIndex == currentIndex && currentIndex != null
            ? AnimatedBars(
                animation1: animation1,
                animation2: animation2,
                animation3: animation3,
              )
            : const Text(""),
      ),
    );
  }
}
