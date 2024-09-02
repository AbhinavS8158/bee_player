import 'dart:async';

import 'package:bee_player/db/functions/db_functions.dart';
import 'package:bee_player/db/model/db_modal.dart';
import 'package:bee_player/screens/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';
import 'package:list_all_videos/list_all_videos.dart';
import 'package:list_all_videos/model/video_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final ListAllVideos _allVideos = ListAllVideos();
  late Box<SongHive> songsBox;
  late Box<VideoHive> videoBox;
  late Box appDataBox; 
  bool _hasPermission = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    await openHiveBoxes();
    await checkAndRequestPermissions();
  }

  Future<void> openHiveBoxes() async {
    songsBox = await Hive.openBox<SongHive>('song_hive');
    videoBox = await Hive.openBox<VideoHive>('videosBox');
    appDataBox = await Hive.openBox('appData'); 
  }

  Future<void> checkAndRequestPermissions({bool retry = false}) async {
    _hasPermission = await _audioQuery.checkAndRequest(retryRequest: retry);
    if (_hasPermission) {
     
      bool isDataFetched = appDataBox.get('isDataFetched', defaultValue: false);

      if (!isDataFetched) {
       
        await fetchAndStoreData();
       
        appDataBox.put('isDataFetched', true);
      }
    }
    _navigateHome();
  }

  Future<void> fetchAndStoreData() async {
    final List<Future<void>> futures = [
      fetchAndStoreSongs(),
      fetchAndStoreVideos(),
    ];
    await Future.wait(futures);
  }

  Future<void> fetchAndStoreSongs() async {
    List<SongModel> songs = await _audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    await saveSongsToHive(songs);
  }

  Future<void> fetchAndStoreVideos() async {
    List<VideoDetails> videos = await _allVideos.getAllVideosPath();
    await saveVideosToHive(videos);
    getAllVideos(); 
  }

  void _navigateHome() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    setState(() {
      _isLoading = false;
    });
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) => const Bottom_navigation(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 1),
                    colors: <Color>[
                      Color(0xff870160),
                      Color(0xffac255e),
                      Color(0xffca485c),
                      Color(0xffe16b5c),
                      Color(0xfff39060),
                      Color(0xffffb56b),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/music (1).png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.none,
                    ),
                    const Text(
                      "bEE PlAYeR",
                      style: TextStyle(
                        color: Colors.white38,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
