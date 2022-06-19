import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
//****

class Bloc with ChangeNotifier {
  //
  static AudioPlayer audioPlayer = AudioPlayer();
  static AudioPlayer player = AudioPlayer();
  static OnAudioQuery audioQuery = OnAudioQuery();
  static List<SongModel> songs = [];
  static List<SongModel> favoriteSongs = [];
  static List<PlaylistModel> playLists = [];
  static String currentSongTitle = "Song Name";
  static String currentSongArtist = "Song Artist";
  static String currentSongName = "Song Display";
  static int currentIndex = 0;
}
