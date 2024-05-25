import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'env.dart';


void main() {
  Client client = Client();
  AppwritePoints points = AppwritePoints();
  client
      .setEndpoint(points.endpoint)
      .setProject(points.projectId)
      .setSelfSigned(status: true); // F
  runApp(const MyApp());
}
