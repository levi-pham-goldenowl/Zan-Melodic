part of 'playlist_detail_bloc.dart';

class PlaylistDetailState extends UpperControlState {
  final XHandle<List<SongModel>> items;
  final PlaylistModel playlist;
  final int numberSongs;

  int idSong({required List<SongModel> list, required SongModel song}) {
    late final int result;
    for (int i = 0; i < list.length; i++) {
      if (song.title == list[i].title && song.size == list[i].size) {
        result = list[i].id;
      }
    }

    return result;
  }

  void sortListByName1(
          {bool reverse = false, required List<SongModel> songs}) =>
      (songs).sort((a, b) => reverse
          ? (b.title).compareTo((a.title))
          : (a.title).compareTo((b.title)));

  const PlaylistDetailState({
    required this.items,
    bool isSortName = false,
    bool isShuffle = false,
    required this.playlist,
    this.numberSongs = 0,
  }) : super(isShuffle: isShuffle, isSortName: isSortName);

  @override
  List<Object?> get props => [
        items,
        isSortName,
        isShuffle,
        playlist,
        numberSongs,
      ];

  @override
  PlaylistDetailState copyWithItems({
    XHandle<List<SongModel>>? items,
    bool? isSortName,
    bool? isShuffle,
    PlaylistModel? playlist,
    int? numberSongs,
  }) {
    return PlaylistDetailState(
      items: items ?? this.items,
      isSortName: isSortName ?? this.isSortName,
      isShuffle: isShuffle ?? this.isShuffle,
      playlist: playlist ?? this.playlist,
      numberSongs: numberSongs ?? this.numberSongs,
    );
  }
}
