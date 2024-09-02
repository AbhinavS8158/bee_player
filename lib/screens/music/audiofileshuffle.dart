import 'dart:math';

import 'package:bee_player/db/model/db_modal.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioFileShuffle extends StatefulWidget {
  final String song;
  final List<SongHive> allSongs;
  final int currentIndex;
  final ValueChanged<int> onSongChanged;

  const AudioFileShuffle({
    super.key,
    required this.song,
    required this.allSongs,
    required this.currentIndex,
    required this.onSongChanged,
  });

  @override
  State<AudioFileShuffle> createState() => _AudioFileShuffleState();
}

class _AudioFileShuffleState extends State<AudioFileShuffle> {
  late AudioPlayer _audioPlayer;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool isPlaying = false;
  late int currentIndex;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    currentIndex = widget.currentIndex;
    _setAudio(widget.allSongs[currentIndex].path);

    _audioPlayer.durationStream.listen((duration) {
      setState(() {
        _duration = duration ?? Duration.zero;
      });
    });

    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _position = position;
      });
    });

    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _next();
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _setAudio(String song) async {
    await _audioPlayer.setUrl(song);
    _audioPlayer.play();
    setState(() {
      isPlaying = true;
    });
  }

  void _next() {
    // Select a random song index
    int nextIndex;
    do {
      nextIndex = _random.nextInt(widget.allSongs.length);
    } while (nextIndex == currentIndex); // Avoid repeating the current song

    setState(() {
      currentIndex = nextIndex;
      widget.onSongChanged(currentIndex);
      _setAudio(widget.allSongs[currentIndex].path);
    });
  }

  void _previous() {
    if (currentIndex > 0) {
      currentIndex--;
      widget.onSongChanged(currentIndex);
      _setAudio(widget.allSongs[currentIndex].path);
    }
  }

  Widget btnStart() {
    return IconButton(
      icon: Icon(
        isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
        size: 80,
      ),
      onPressed: () {
        setState(() {
          if (isPlaying) {
            _audioPlayer.pause();
          } else {
            _audioPlayer.play();
          }
          isPlaying = !isPlaying;
        });
      },
    );
  }

  Widget slider() {
    return Row(
      children: [
        Text(
          "${_position.inMinutes}:${_position.inSeconds.remainder(60).toString().padLeft(2, '0')} ",
          style: const TextStyle(color: Colors.white),
        ),
        Expanded(
          child: Slider(
            activeColor: Colors.purple,
            inactiveColor: Colors.grey,
            value: _position.inSeconds.toDouble(),
            min: 0.0,
            max: _duration.inSeconds.toDouble(),
            onChanged: (double value) {
              setState(() {
                _audioPlayer.seek(Duration(seconds: value.toInt()));
              });
            },
          ),
        ),
        Text(
          "${_duration.inMinutes}:${_duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget previous() {
    return IconButton(
      onPressed: _previous,
      icon: const Icon(Icons.skip_previous, size: 80),
    );
  }

  Widget next() {
    return IconButton(
      onPressed: _next,
      icon: const Icon(Icons.skip_next, size: 80),
    );
  }

  Widget loadAsset() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        slider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            previous(),
            btnStart(),
            next(),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: loadAsset(),
      ),
    );
  }
}
