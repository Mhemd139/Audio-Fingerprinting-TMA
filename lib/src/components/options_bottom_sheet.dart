import 'package:flutter/material.dart';
import 'package:tma/src/models/audio_model.dart';
import 'package:tma/src/services/storage_services.dart';

import 'bottom_sheet_container.dart';
import 'option_list_tile.dart';

class OptionsBottomSheet extends StatelessWidget {
  const OptionsBottomSheet({super.key, required this.audioModel});
  final AudioModel audioModel;
  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      child: Column(
        children: [
          OptionListTile(
            iconData: Icons.edit_outlined,
            title: 'Edit',
          ),
          OptionListTile(
            title: 'Share',
            onTap: () {
              StorageServices.shareMusic(audioModel.path);
            },
            iconData: Icons.share_outlined,
          ),
          OptionListTile(
            title: 'Delete from playlist',
            iconData: Icons.remove_circle_outline,
          ),
        ],
      ),
    );
  }
}
