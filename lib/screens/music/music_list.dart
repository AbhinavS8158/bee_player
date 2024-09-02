import 'dart:developer';

import 'package:bee_player/db/functions/db_functions.dart';
import 'package:bee_player/db/model/db_modal.dart';
import 'package:bee_player/screens/music/music_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget listTileList(BuildContext context, int index, SongHive item, List<SongHive> song) {
  return ListTile(
    onTap: () {
      log(item.path);
      log("Title: ${item.title}");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MusicScreen(
            songs: song,
            index: index,
          ),
        ),
      );
    },
    title: Text(
      item.title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.eduVicWaNtBeginner(
      color: Colors.white,
    ),
    ),
    subtitle: Text(
      item.artist ?? 'Unknown Artist',
      style: const TextStyle(color: Colors.white70),
    ),
    leading: const Icon(Icons.music_note, color: Colors.white),
    trailing: IconButton(
      onPressed: () {
        _showMoreOptions(context, item);
      },
      icon: const Icon(Icons.more_vert, color: Colors.white),
    ),
  );
}

void _showMoreOptions(BuildContext context, SongHive song) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Wrap(
        children: <Widget>[
          ListTile(
            leading: Icon(
              song.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: song.isFavorite ? Colors.purple : null,
            ),
            title: Text(song.isFavorite ? 'Remove from Favorites' : 'Add to Favorites'),
            onTap: () {
              _toggleFavorite(song);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.play_arrow),
            title: const Text('Play Music'),
            onTap: () {
               Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MusicScreen(
                    songs: [song],
                    index: 0,
                  ),
                ),
                
              );
              
            },
          
          ),
        ],
      );
    },
  );
}

void _toggleFavorite(SongHive song) async {
  song.isFavorite = !song.isFavorite;
  await song.save(); 
  updateFav(song); 
}
