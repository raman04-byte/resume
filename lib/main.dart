import 'package:flutter/material.dart';
import 'app.dart';
import 'env.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppwritePoints points = AppwritePoints();
  client
      .setEndpoint(points.endpoint)
      .setProject(points.projectId)
      .setSelfSigned(status: true);
  runApp(const MyApp());
}
