import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline_map/pages/bundled_offline_map.dart';
import 'package:flutter_offline_map/pages/home.dart';
import 'package:flutter_offline_map/widgets/drawer/menu_item.dart';

const _isWASM = bool.fromEnvironment('dart.tool.dart2wasm');

class MenuDrawer extends StatelessWidget {
  final String currentRoute;

  const MenuDrawer(this.currentRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/ProjectIcon.png',
                  height: 48,
                ),
                const SizedBox(height: 16),
                const Text(
                  'flutter_map Demo',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(
                  '© flutter_map Authors & Contributors',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                if (kIsWeb)
                  const Text(
                    _isWASM ? 'Running with WASM' : 'Running without WASM',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
              ],
            ),
          ),
          MenuItemWidget(
            caption: 'Home',
            routeName: HomePage.route,
            currentRoute: currentRoute,
            icon: const Icon(Icons.home),
          ),
          const Divider(),
          MenuItemWidget(
            caption: 'Bundled Offline Map',
            routeName: BundledOfflineMapPage.route,
            currentRoute: currentRoute,
          ),
        ],
      ),
    );
  }
}
