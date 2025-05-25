import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tma/src/res/app_style.dart';

import '../controller/state_controller.dart';
import 'bottom_sheet_container.dart';

class TimerBottomSheet extends StatefulWidget {
  TimerBottomSheet({super.key});

  @override
  State<TimerBottomSheet> createState() => _TimerBottomSheetState();
}

class _TimerBottomSheetState extends State<TimerBottomSheet> {
  Map<String, Duration> timerList = {
    '10 minutes': Duration(minutes: 10),
    '15 minutes': Duration(minutes: 15),
    '20 minutes': Duration(minutes: 20),
  };

  Duration timerDuration = Duration(days: 1);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StateController>(builder: (stateController) {
      if (stateController.isTimerRunning) {
        timerDuration = stateController.selectedDuration;
      }
      return BottomSheetContainer(
        child: Column(
          children: [
            Text(
              'Run timer',
              style: AppStyle.appTextStyles.headLineStyle,
            ),
            // for(var timeOption in timerList)
            // for (int i = 0; i < timerList.length; i++)
            _timerItem('10 minutes'),
            _timerItem('15 minutes'),
            _timerItem('20 minutes'),
            Row(
              mainAxisAlignment: !stateController.isTimerRunning
                  ? MainAxisAlignment.spaceAround
                  : MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: !stateController.isTimerRunning,
                  child: _timerButton(
                    title: 'Start',
                    onTap: () {
                      if (timerDuration > Duration(hours: 20)) {
                      } else {
                        stateController.isTimerRunning = true;
                        stateController.selectedDuration = timerDuration;
                        stateController.update();
                        stateController.runTimer(duration: timerDuration);
                        Get.back();
                      }
                    },
                    color: Colors.indigo,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _timerButton(
                  title: 'Cancel',
                  onTap: () {
                    stateController.isTimerRunning = false;
                    stateController.update();
                    Get.back();
                  },
                  color: Colors.white,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.indigo,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }

  Widget _timerItem(String title) {
    bool isSelected = timerList[title] == timerDuration;
    return InkWell(
      onTap: () {
        setState(() {
          timerDuration = timerList[title]!;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          title,
          style: isSelected
              ? AppStyle.appTextStyles.headLineStyle
              : AppStyle.appTextStyles.boldStyle,
        ),
      ),
    );
  }

  Widget _timerButton({
    required String title,
    required Color color,
    TextStyle? style,
    void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // padding: EdgeInsets.all(10),
        height: 40,
        width: 80,
        alignment: Alignment.center,
        child: Text(
          title,
          style: style,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
