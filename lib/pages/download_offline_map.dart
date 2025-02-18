import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_offline_map/misc/tile_providers.dart';
import 'package:flutter_offline_map/widgets/drawer/menu_drawer.dart';
import 'package:latlong2/latlong.dart';

class DownloadOfflineMap extends StatelessWidget {
  static const String route = '/download_offline_map';

  const DownloadOfflineMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Download Offline Map')),
      drawer: const MenuDrawer(route),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: const LatLng(1.29027, 103.851959),
          minZoom: 12,
          maxZoom: 17,
          cameraConstraint: CameraConstraint.containCenter(
            bounds: LatLngBounds(
              const LatLng(1.33327, 103.931959),
              const LatLng(1.21027, 103.801959),
            ),
          ),
        ),
        children: [
          openStreetMapTileLayer,
        ],
      ),
    );
  }
}