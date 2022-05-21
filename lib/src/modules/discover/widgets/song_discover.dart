import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanmelodic/src/config/themes/my_colors.dart';
import 'package:zanmelodic/src/config/themes/styles.dart';
import 'package:zanmelodic/src/constants/my_properties.dart';
import 'package:zanmelodic/src/models/audio_model.dart';
import 'package:zanmelodic/src/modules/audio_control/logic/audio_handle_bloc.dart';
import 'package:zanmelodic/src/widgets/custom_text/custom_text.dart';
import 'package:zanmelodic/src/widgets/state/state_empty_widget.dart';

class SongDiscoverWidget extends StatelessWidget {
  const SongDiscoverWidget({Key? key, required this.audios}) : super(key: key);
  final List<XAudio> audios;

  @override
  Widget build(BuildContext context) {
    return audios.isNotEmpty
        ? SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return _buildCard(context,
                    audio: audios[index], audios: audios, index: index);
              }, childCount: audios.length),
            ),
          )
        : const XStateEmptyWidget();
  }

  Widget _buildCard(
    BuildContext context, {
    required XAudio audio,
    required List<XAudio> audios,
    required int index,
  }) {
    const pVer = 6.0;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, pVer, 20, pVer),
      child: GestureDetector(
        onTap: () => context
            .read<AudioHandleBloc>()
            .skipToQueueItem(index: index, audios: audios),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: MyProperties.borderRadius,
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                audio.image,
                gaplessPlayback: false,
                repeat: ImageRepeat.noRepeat,
                scale: 1.0,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.low,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CusText(
                    title: '${audio.name}\n',
                    style: Style.textTheme().titleMedium,
                  ),
                  CusText(
                      title: audio.author,
                      style: Style.textTheme()
                          .titleMedium!
                          .copyWith(fontSize: 17, color: MyColors.colorGray))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
