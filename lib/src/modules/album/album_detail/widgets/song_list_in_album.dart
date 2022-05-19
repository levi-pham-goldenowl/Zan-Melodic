import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanmelodic/src/modules/album/album_detail/logic/album_detail_bloc.dart';
import 'package:zanmelodic/src/modules/audio_control/logic/audio_handle_bloc.dart';
import 'package:zanmelodic/src/widgets/custom_card/song_card.dart';
import 'package:zanmelodic/src/widgets/state/state_empty_widget.dart';

class SongListInAlbum extends StatelessWidget {
  const SongListInAlbum({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumDetailBloc, AlbumDetailState>(
        builder: (context, state) {
      return BlocBuilder<AudioHandleBloc, AudioHandleState>(
        builder: (context, audioState) {
          final _items = state.items.data ?? [];
          state.isSortName
              ? state.sortListByName(
                  reverse: true,
                )
              : state.sortListByName();
          return _items.isNotEmpty
              ? SliverPadding(
                  padding: audioState.isShowBottomBar == true
                      ? const EdgeInsets.only(bottom: 90)
                      : EdgeInsets.zero,
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: SongCard(
                                song: _items[index],
                                onTap: () => context
                                    .read<AudioHandleBloc>()
                                    .skipToQueueItem(
                                      items: _items,
                                      index: index,
                                    ),
                              ),
                            ),
                        childCount: _items.length),
                  ),
                )
              : const XStateEmptyWidget();
        },
      );
    });
  }
}
