import 'dart:developer';

import 'package:bee_player/db/model/db_modal.dart';
import 'package:bee_player/screens/music/music_screen.dart';
import 'package:flutter/material.dart';

class Addsongs extends StatefulWidget {
  final int index;
  final SongHive item;
  final List<SongHive> song;
  final bool isChecked;
  final ValueChanged<bool?> onCheckboxChanged;

  const Addsongs({
    required this.index,
    required this.item,
    required this.song,
    required this.isChecked,
    required this.onCheckboxChanged,
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AddsongsState createState() => _AddsongsState();
}

class _AddsongsState extends State<Addsongs> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        log('Song Path: ${widget.item.path}');
        log('Song Title: ${widget.item.title}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MusicScreen(
              songs: widget.song,
              index: widget.index,
            ),
          ),
        );
      },
      title: Text(
        widget.item.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        widget.item.artist,
        style: const TextStyle(color: Colors.white70),
      ),
      leading: const Icon(Icons.music_note),
      trailing: Checkbox(
        value: widget.isChecked,
        onChanged: (bool? value) {
          setState(() {
            widget.onCheckboxChanged(value);
          });
        },
      ),
    );
  }
}
