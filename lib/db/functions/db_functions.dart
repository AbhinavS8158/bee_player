import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bee_player/db/model/db_modal.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:list_all_videos/model/video_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:video_player/video_player.dart';

ValueNotifier<List<SongHive>> songlistNotifier = ValueNotifier([]);
Future<void> saveSongsToHive(List<SongModel> songs) async {
  final songDb = await Hive.openBox<SongHive>('song_db');
  if (songDb.isEmpty) {
    for (var song in songs) {
      final songHive = SongHive(
        id: song.id.toString(),
        title: song.title,
        artist: song.artist ?? 'Unknown Artist',
        path: song.data,
      );
      log(".....................${songHive.path}");
      log('Favorite Songs:');
      await songDb.add(songHive);
    }
  }
}

void getAllSongs() async {
  final songDb = await Hive.openBox<SongHive>('song_db');
  songlistNotifier.value.clear();
  songlistNotifier.value.addAll(songDb.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  songlistNotifier.notifyListeners();
}

void searchSongs(String query) async {
  final songDb = await Hive.openBox<SongHive>('song_db');
  final allSongs = songDb.values.toList();
  final filteredSongs = allSongs.where((song) {
    final titleLower = song.title.toLowerCase();
    final artistLower = song.artist.toLowerCase();
    final searchLower = query.toLowerCase();
    return titleLower.contains(searchLower) ||
        artistLower.contains(searchLower);
  }).toList();
  songlistNotifier.value.clear();
  songlistNotifier.value.addAll(filteredSongs);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  songlistNotifier.notifyListeners();
}

Future<List<SongHive>> getFavoriteSongs() async {
  final songDb = await Hive.openBox<SongHive>('song_db');
  final favoriteSongs = songDb.values.where((song) => song.isFavorite).toList();
  return favoriteSongs;
}

Future<void> saveFavoriteStatus(SongHive song) async {
  final songBox = await Hive.openBox<SongHive>('song_db');
  songBox.put(song.id, song);
}

Future<void> markAsFavorite(SongHive song) async {
  song.isFavorite = true;
  await saveFavoriteStatus(song);
}

Future<void> removeFromFavorites(SongHive song) async {
  song.isFavorite = false;
  await saveFavoriteStatus(song);
}

Future<void> updateFav(SongHive song) async {
  final songBox = await Hive.openBox<SongHive>('song_db');
  final index =
      songBox.values.toList().indexWhere((element) => element.id == song.id);
  songBox.putAt(index, song);

  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  songlistNotifier.notifyListeners();
}




Future<List<SongHive>> getPlaylistSong(Playlist playlist) async {
  final List<SongHive> fetchedSong = [];
  final List<String> songsId = playlist.songsId;
  final songBox = await Hive.openBox<SongHive>('song_db');

  for (var song in songBox.values) {
    if (songsId.contains(song.id)) {
      fetchedSong.add(song);
    }
  }

  return fetchedSong;
}




Future<void> deleteSongFromPlaylist(Playlist playlist, SongHive song) async {
  final playlistBox = Hive.box<Playlist>('playlists');
  final index = playlistBox.values
      .toList()
      .indexWhere((element) => element.id == playlist.id);
  final currentPlaylist = playlistBox.getAt(index);
  if (currentPlaylist != null) {
    currentPlaylist.songsId.remove(song.id);
    await playlistBox.putAt(index, currentPlaylist);
  }
}

Future<void> updatePlaylist(Playlist playlist) async {
  final playlistBox = Hive.box<Playlist>('playlists');
  final index = playlistBox.values
      .toList()
      .indexWhere((element) => element.id == playlist.id);
  playlistBox.putAt(index, playlist);
}

Future<List<SongHive>> getRecentlyPlayedSongs() async {
  final songDb = await Hive.openBox<SongHive>('song_db');

  final songs = songDb.values.toList();

  final recentlyPlayedSongs = songs
      .where((song) => song.lastPlayed != null)
      .toList()
      ..sort((a, b) => b.lastPlayed!.compareTo(a.lastPlayed!));

  return recentlyPlayedSongs;
}

Future<void> resetRecent() async {
  final box = await Hive.openBox<SongHive>('song_db');
 
  final recentlyPlayedSongs = box.values.where((song) => song.lastPlayed != null).toList();
  
  for (var song in recentlyPlayedSongs) {

    song.lastPlayed = null;
    song.save();
  }
}




















ValueNotifier<List<VideoHive>> videolistNotifier = ValueNotifier([]);


Future<String> getVideoDuration(String videoPath) async {
  VideoPlayerController controller = VideoPlayerController.file(File(videoPath));
  await controller.initialize();
  Duration duration = controller.value.duration;
  controller.dispose();

  String formattedDuration = duration.inHours > 0
      ? "${duration.inHours}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}"
      : "${duration.inMinutes}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}";

  return formattedDuration;
}

Future saveVideosToHive(List<VideoDetails> videos) async {
  final videoDb = await Hive.openBox<VideoHive>('video_db');

  if (videoDb.isEmpty) {
    for (var video in videos) {
        String duration = await getVideoDuration(video.videoPath);
    
      final videoHive = VideoHive(
        name: video.videoName,
        path: video.videoPath,
        size: video.videoSize,
        thumbnail: video.thumbnailController.toString(),
        id: DateTime.now().millisecond.toString(),
        duration:duration,
        
    
     
      );
      await videoDb.add(videoHive);
    
    }
  }
}

void getAllVideos() async {
  final videoDb = await Hive.openBox<VideoHive>('video_db');
  videolistNotifier.value.clear();
  videolistNotifier.value.addAll(videoDb.values);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  videolistNotifier.notifyListeners();
}

void searchVideos(String query) async {
  final videoDb = await Hive.openBox<VideoHive>('video_db');
  final allVideos = videoDb.values.toList();
  final filteredVideos = allVideos.where((video) {
    final nameLower = video.name.toLowerCase();
    final searchLower = query.toLowerCase();
    return nameLower.contains(searchLower);
  }).toList();
  videolistNotifier.value.clear();
  videolistNotifier.value.addAll(filteredVideos);
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  videolistNotifier.notifyListeners();
}

Future<void> addVideoPlaylist(Videoplaylist playlist) async {
  final vidPlayListBox = await Hive.openBox<Videoplaylist>('video_playlist');
  // ignore: unnecessary_null_comparison
  if (playlist != null) {
    vidPlayListBox.add(playlist);
  }
}


Future<List<VideoHive>> getPlaylistVideos(Videoplaylist videoplaylist) async {
  final List<VideoHive> fetchedVideos = [];
  final List<String> videosId = videoplaylist.videosId;
  final videoBox = await Hive.openBox<VideoHive>('video_db');

  for (var video in videoBox.values) {
    if (videosId.contains(video.id)) {
      fetchedVideos.add(video);
    }
  }
  return fetchedVideos;
}

Future<void> deleteVideoFromPlayList(
    Videoplaylist playlist, VideoHive video) async {
  final playlistBox = Hive.box<Videoplaylist>('video_playlist');
  final index = playlistBox.values
      .toList()
      .indexWhere((element) => element.id == playlist.id);
  final currentPlaylist = playlistBox.getAt(index);
  if (currentPlaylist != null) {
    currentPlaylist.videosId.remove(video.id);
    await playlistBox.putAt(index, currentPlaylist);
  }
}

Future<void> updatevideoPlaylist(Videoplaylist playlist) async {
  final playlistBox = Hive.box<Videoplaylist>('video_playlist');
  final index = playlistBox.values
      .toList()
      .indexWhere((element) => element.id == playlist.id);
  playlistBox.putAt(index, playlist);
}


List<VideoHive> getRecentlyPlayedVideos(List<VideoHive> allVideos) {
  allVideos.sort((a, b) {
    if (a.lastPlayed == null && b.lastPlayed == null) return 0;
    if (a.lastPlayed == null) return 1;
    if (b.lastPlayed == null) return -1;
    return b.lastPlayed!.compareTo(a.lastPlayed!);
  });

  return allVideos.where((video) => video.lastPlayed != null).toList();
}

// db_functions.dart

Future<void> resetVideoRecent() async {
  final videoDb = await Hive.openBox<VideoHive>('video_db');
  final videos = videoDb.values.where((video) => video.lastPlayed != null).toList();

  for (var video in videos) {
    video.lastPlayed = null; // Reset the lastPlayed timestamp
    video.save();
  }
}



