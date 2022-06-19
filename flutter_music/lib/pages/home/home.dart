import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_music/pages/home/player.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../helpers/neumorphic_button.dart';
import 'package:we_slide/we_slide.dart';
import '../../Bloc/bloc.dart';
import './body/home_body.dart';
import './home_appbar.dart';
import './playerHeader.dart';
//****

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with ChangeNotifier {
  //

  @override
  void initState() {
    super.initState();
    requestPermission();
    Bloc.audioPlayer.currentIndexStream.listen((int? index) {
      if (index != null) {
        updateCurrentPlayingSongDetails(index);
      }
    });
  }

  requestPermission() async {
    // Web platform don't support permissions methods.
    if (!kIsWeb) {
      PermissionStatus permissionStatus = await Permission.storage.status;
      if (!permissionStatus.isGranted) {
        await Permission.storage.request();
      }
    }
  }

  @override
  void dispose() {
    Bloc.audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    const double panelMinSize = 80.0;
    final double panelMaxSize = MediaQuery.of(context).size.height;
    //

    return SafeArea(
      child: Scaffold(
        backgroundColor: NeumorphicTheme.baseColor(context),

        body: WeSlide(
          appBarHeight: 130,
          backgroundColor: NeumorphicTheme.baseColor(context),
          appBar: MyAppBar(
            appbar: PreferredSize(
              child: AppBar(),
              preferredSize: const Size.fromHeight(130),
            ),
            title: const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "PLAYLIST",
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 1,
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.bold,
                  color: Colors.white30,
                ),
              ),
            ),
            actions: <Widget>[
              // ignore: missing_required_param
              renderButton(
                icon: Icons.queue_music,
                iconColor: Colors.grey,
                height: 50,
                width: 50,
                padding: const EdgeInsets.only(right: 40, top: 10),
                onTap: () {
                  Navigator.pushNamed(context, "playlistPage");
                },
              )
            ],
            backgroundColor: NeumorphicTheme.baseColor(context),
            child: const Text(""),
          ),
          panelMinSize: panelMinSize,
          panelMaxSize: panelMaxSize,
          body: const MyBody(),
          panel: const Player(),
          panelHeader: const PlayerHeader(),
          panelBorderRadiusBegin: 75,
          panelBorderRadiusEnd: 75,
        ),
        extendBody: true,
        // bottomNavigationBar: const PlayTrack(),
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
        Bloc.currentSongName = Bloc.songs[index].displayName;
      }
    });
  }
}
