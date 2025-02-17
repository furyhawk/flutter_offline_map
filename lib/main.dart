import 'package:flutter/material.dart';
import 'package:flutter_offline_map/pages/home.dart';
import 'package:flutter_offline_map/pages/bundled_offline_map.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_map offline',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF8dea88),
      ),
      home: const HomePage(),
      routes: <String, WidgetBuilder>{
        BundledOfflineMapPage.route: (context) => const BundledOfflineMapPage(),
      },
    );
  }
}
