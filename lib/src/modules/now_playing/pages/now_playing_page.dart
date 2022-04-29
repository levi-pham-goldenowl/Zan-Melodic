import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zanmelodic/src/config/routes/coordinator.dart';
import 'package:zanmelodic/src/config/themes/my_colors.dart';
import 'package:zanmelodic/src/config/themes/styles.dart';
import 'package:zanmelodic/src/modules/now_playing/widgets/control_bar_now_playing.dart';
import 'package:zanmelodic/src/modules/now_playing/widgets/custom_process_bar.dart';
import 'package:zanmelodic/src/modules/play_music/logic/play_music_bloc.dart';
import 'package:zanmelodic/src/modules/songs/logic/song_list_bloc.dart';
import 'package:zanmelodic/src/utils/enums/loop_mode.dart';

class NowPlayingPage extends StatelessWidget {
  const NowPlayingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pTop = MediaQuery.of(context).padding.top;
    const _pHori = 40.0;
    return BlocBuilder<PlayMusicBloc, PlayMusicState>(
        builder: (context, state) {
      final _song = state.song;
      return BlocBuilder<SongListBloc, SongListState>(
        builder: (context, songState) {
          return Scaffold(
            backgroundColor: MyColors.colorBackground,
            body: GestureDetector(
              onVerticalDragEnd: (details) => XCoordinator.pop(context),
              child: Padding(
                  padding:
                      EdgeInsets.fromLTRB(_pHori, _pTop, _pHori, _pHori / 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Now Playing',
                        style: Style.textTheme().displaySmall,
                      ),
                      _image(_song.id),
                      _infoSongWidget(_song),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _customIconButton(
                            icon: songState.shuffleIcon,
                            onPressed: () =>
                                context.read<SongListBloc>().onShuffleToList(),
                          ),
                          _customIconButton(
                            icon: state.loopMode.iconOf(),
                            onPressed: () =>
                                context.read<PlayMusicBloc>().onLoopMode(),
                          ),
                        ],
                      ),
                      const CutomProcessBar(),
                      const ControlBarNowPlaying(),
                    ],
                  )),
            ),
          );
        },
      );
    });
  }

  Widget _image(int id) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 220,
        width: 220,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
          BoxShadow(
            offset: const Offset(10, 20),
            color: MyColors.colorShadowImageNowPlaying.withOpacity(0.25),
          )
        ]),
        child: QueryArtworkWidget(
          artworkBorder: BorderRadius.circular(20.0),
          id: id,
          type: ArtworkType.AUDIO,
          keepOldArtwork: true,
          nullArtworkWidget: const Icon(
            Icons.image_not_supported,
            size: 240,
            color: MyColors.colorWhite,
          ),
        ),
      ),
    );
  }

  Widget _infoSongWidget(SongModel songModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${songModel.title}\n',
          style: Style.textTheme().displayLarge,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(songModel.artist ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Style.textTheme().titleMedium!.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: MyColors.colorGray))
      ],
    );
  }

  Widget _customIconButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return SizedBox(
      height: 40,
      width: 40,
      child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 20,
            color: MyColors.colorWhite,
          )),
    );
  }
}
