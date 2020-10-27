import 'package:flutter/material.dart';
import 'src/Repository/appLocalization.dart';
import 'src/app.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;
void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  await localization.init();

  WidgetsFlutterBinding.ensureInitialized();

  final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();
  runApp(MyApp(
    navigator: navigator,
  ));
}

