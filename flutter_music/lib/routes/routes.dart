import 'package:flutter/material.dart';
import 'package:flutter_music/pages/favorites/favorite_playlist.dart';
import '../pages/home/home.dart';
import '../pages/intro/intro_pages.dart';
import '../pages/playlist/playlist.dart';
//****

class Routes {
//
  static const String introPage = "introPage";
  static const String mainPage = "homePage";
  static const String favoriteListPage = "favoriteListPage";
  static const String playlistPage = "playlistPage";

  static final Map<String, WidgetBuilder> routes = {
    mainPage: (context) => const MyHomePage(),
    introPage: (context) => const IntroPages(),
    favoriteListPage: (context) => const FavoritePlaylist(),
    playlistPage: (context) => const Playlist(),
  };
}
