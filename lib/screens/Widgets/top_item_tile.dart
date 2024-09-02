import 'package:bee_player/db/functions/db_functions.dart';
import 'package:flutter/material.dart';

Widget topItemTile() {
  final TextEditingController searchController = TextEditingController();
  return Row(
    children: [
     
      Expanded(
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search ...',
            hintStyle: const TextStyle(color: Colors.white54),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.white54,
            ),
            filled: true,
            fillColor: Colors.black,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: (value) {
            searchSongs(value);
          },
        ),
      ),
    ],
  );
}
