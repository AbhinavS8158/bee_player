// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongHiveAdapter extends TypeAdapter<SongHive> {
  @override
  final int typeId = 0;

  @override
  SongHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongHive(
      id: fields[0] as String,
      title: fields[1] as String,
      artist: fields[2] as String,
      path: fields[3] as String,
      isFavorite: fields[4] as bool,
      lastPlayed: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, SongHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.artist)
      ..writeByte(3)
      ..write(obj.path)
      ..writeByte(4)
      ..write(obj.isFavorite)
      ..writeByte(5)
      ..write(obj.lastPlayed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VideoHiveAdapter extends TypeAdapter<VideoHive> {
  @override
  final int typeId = 1;

  @override
  VideoHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoHive(
      id: fields[0] as String,
      name: fields[1] as String,
      thumbnail: fields[4] as String,
      path: fields[2] as String,
      size: fields[3] as String,
      duration: fields[5] as String,
      lastPlayed: fields[6] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, VideoHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.path)
      ..writeByte(3)
      ..write(obj.size)
      ..writeByte(4)
      ..write(obj.thumbnail)
      ..writeByte(5)
      ..write(obj.duration)
      ..writeByte(6)
      ..write(obj.lastPlayed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlaylistAdapter extends TypeAdapter<Playlist> {
  @override
  final int typeId = 2;

  @override
  Playlist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Playlist(
      name: fields[0] as String,
      songsId: (fields[1] as List).cast<String>(),
      id: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Playlist obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.songsId)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VideoplaylistAdapter extends TypeAdapter<Videoplaylist> {
  @override
  final int typeId = 3;

  @override
  Videoplaylist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Videoplaylist(
      id: fields[0] as String,
      name: fields[1] as String,
      videosId: (fields[2] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Videoplaylist obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.videosId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoplaylistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
