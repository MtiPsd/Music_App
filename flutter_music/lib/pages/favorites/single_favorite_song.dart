import 'package:flutter_music/pages/favorites/slidable.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../Bloc/bloc.dart';
import '../../helpers/source_controller.dart';
//****

class SingleFavoriteSong extends StatefulWidget {
  const SingleFavoriteSong(this.index, {Key? key}) : super(key: key);

  final int index;

  @override
  State<SingleFavoriteSong> createState() => _SingleFavoriteSongState();
}

class _SingleFavoriteSongState extends State<SingleFavoriteSong>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
//
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();

    controllBar1();
    controllBar2();
    controllBar3();
  }

  void controllBar1() {
    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 1),
    );

    _animation1 = CurvedAnimation(
      parent: Tween<double>(begin: 0.0, end: 0.9).animate(_controller1),
      curve: Curves.bounceOut,
    );
    _controller1.repeat(reverse: true);
  }

  void controllBar2() {
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 1),
    );

    _animation2 = CurvedAnimation(
      parent: Tween<double>(begin: 0.9, end: 0.0).animate(_controller2),
      curve: Curves.bounceOut,
    );

    _controller2.repeat(reverse: true);
  }

  void controllBar3() {
    _controller3 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 1),
    );

    _animation3 = CurvedAnimation(
      parent: Tween<double>(begin: 1.0, end: 0.2).animate(_controller3),
      curve: Curves.bounceOut,
    );
    _controller3.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//
    super.build(context);

//

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: InkWell(
        onTap: play,
        onDoubleTap: play,
        child: StreamBuilder(
          stream: Bloc.player.currentIndexStream,
          builder: (BuildContext context, AsyncSnapshot<int?> snapshot) {
            //
            int? currentIndex = snapshot.data;
            int? selectedSongId = Bloc.favoriteSongs[widget.index].id;

            return FavoriteSlidable(
              selectedSongId: selectedSongId,
              currentIndex: currentIndex,
              animation1: _animation1,
              animation2: _animation2,
              animation3: _animation3,
              index: widget.index,
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void play() async {
    await Bloc.player.setAudioSource(
      createPlayList(Bloc.favoriteSongs),
      initialIndex: widget.index,
    );

    if (Bloc.player.currentIndex != null) {
      Bloc.player.play();
    }
  }
}
