
import 'package:bee_player/db/model/db_modal.dart';
import 'package:flutter/material.dart';
import 'package:list_all_videos/model/thumbnail_controller.dart';
import 'package:list_all_videos/thumbnail/ThumbnailTile.dart';

class Addvideos extends StatefulWidget {
  final int index;
  final VideoHive item;
  final List<VideoHive> video;
  final bool isChecked;
  final ValueChanged<bool?> onCheckboxChanged;

  const Addvideos({
    required this.index,
    required this.item,
    required this.video,
    required this.isChecked,
    required this.onCheckboxChanged,
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AddsongsState createState() => _AddsongsState();
}

class _AddsongsState extends State<Addvideos> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // log('Song Path: ${widget.item.path}');
        // log('Song Title: ${widget.item.title}');
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => MusicScreen(
        //       songs: widget.,
        //       index: widget.index,
        //     ),
        //   ),
        // );
      },
      title: Text(
        widget.item.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        widget.item.size,
        style: const TextStyle(color: Colors.white70),
      ),
       leading: SizedBox(
        height: 60,
        width: 80,  
        child: ThumbnailTile(thumbnailController: ThumbnailController(videoPath: widget.item.path))),
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
