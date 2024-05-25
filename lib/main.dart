import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:resume/env.dart';

import 'app.dart';

void main() {
  // Initialize Appwrite
  // Create a env file in the lib folder and add the following:
  Client client = Client();
  client
      .setEndpoint(endpoint)
      .setProject(projectId)
      .setSelfSigned(status: true); // F
  runApp(const MyApp());
}
