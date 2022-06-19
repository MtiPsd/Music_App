import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

// Create Playlist

ConcatenatingAudioSource createPlayList(List<SongModel> songs) {
  List<AudioSource> sources = [];

  for (var song in songs) {
    sources.add(AudioSource.uri(Uri.parse(song.uri!)));
  }
  return ConcatenatingAudioSource(
    children: sources,
  );
}
