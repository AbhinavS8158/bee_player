
import 'package:hive_flutter/adapters.dart';

part 'db_modal.g.dart';

@HiveType(typeId: 0)
class SongHive extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String artist;

  @HiveField(3)
  String path;

  @HiveField(4)
  bool isFavorite;

  @HiveField(5)
  DateTime? lastPlayed;

  SongHive({
    required this.id,
    required this.title,
    required this.artist,
    required this.path,
    this.isFavorite = false,
    this.lastPlayed,
  });
}


@HiveType(typeId: 1)
class VideoHive  extends  HiveObject{
 @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String path;

  @HiveField(3)
  String size;

  @HiveField(4)
  String thumbnail;
   @HiveField(5)
  String duration;
 
  @HiveField(6)
  DateTime? lastPlayed;

  VideoHive({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.path,
    required this .size,
    required this. duration,
     this.lastPlayed
    
  });
}
@HiveType(typeId: 2)
class Playlist extends HiveObject {

  @HiveField(0)
  String name;

  @HiveField(1)
  List<String > songsId;
  @HiveField(2)
  String id;

  Playlist({
    required this.name,
    required this.songsId,
    required this.id
  });
}

@HiveType(typeId: 3)
class Videoplaylist extends HiveObject {

  @HiveField(0)
   String id;
   @HiveField(1)
   String name;
   @HiveField(2)
   List<String>videosId;

Videoplaylist({
  required this .id,
  required this .name,
  required this.videosId

});

}

