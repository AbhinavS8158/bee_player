import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget artist_list(){
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 8, 8, 8),
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        child: const ListTile(
          title: Text(
             'Artist Name',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            'Number of songs',
            style: TextStyle(color: Colors.white54),
          ),
         
        ),
      ),
    );
}