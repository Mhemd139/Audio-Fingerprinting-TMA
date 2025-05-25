import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'src/controller/state_controller.dart';
import 'src/res/app_style.dart';
import 'src/views/music_checker_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StateController _stateController =
      Get.put(StateController(), permanent: true);
  @override
  void initState() {
    // Permission.manageExternalStorage.request();
    _stateController.getAudioFromStorage();
    _stateController.getFavorite();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TMA',
      theme: ThemeData(
        fontFamily: 'Roboto',
        useMaterial3: true,
        colorScheme: const ColorScheme.dark().copyWith(
          primary: AppStyle.appColors.primaryColor,
        ),
        scaffoldBackgroundColor: AppStyle.appColors.primaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: AppStyle.appColors.primaryColor,
        ),
      ),
      home: const MusicCheckerView(), //
    );
  }
}
