import 'package:flutter/material.dart';
import 'package:nabandeja/service/io_socket.dart';
import 'package:provider/provider.dart';

import './widget/login/index.dart';
import 'service/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        Provider<NotificationService>(
          create: (context) => NotificationService(),
        ),
        Provider<IoSocket>(
          create: (context) => IoSocket(context.read<NotificationService>()),
        ),
      ],
      child: const LoginApp(),
    ),
  );
}
