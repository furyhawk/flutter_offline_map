import 'package:flutter/material.dart';
import 'dart:io';
import 'package:logging/logging.dart';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:latlong2/latlong.dart';

import 'package:flutter_offline_map/widgets/drawer/menu_drawer.dart';
import 'package:flutter_offline_map/misc/utils.dart';

final log = Logger('download_offline_map');

class DownloadOfflineMap extends StatefulWidget {
  static const String route = '/download_offline_map';
  const DownloadOfflineMap({super.key});

  @override
  State<DownloadOfflineMap> createState() => _DownloadOfflineMapState();
}

class _DownloadOfflineMapState extends State<DownloadOfflineMap> {
  // create the cache store as a field variable
  final Future<CacheStore> _cacheStoreFuture = _getCacheStore();

  /// Get the CacheStore as a Future. This method needs to be static so that it
  /// can be used to initialize a field variable.
  static Future<CacheStore> _getCacheStore() async {
    final dir = await getLocalPath();
    log.fine('dir: $dir.path');
    // Note, that Platform.pathSeparator from dart:io does not work on web,
    // import it from dart:html instead.
    return FileCacheStore('${dir.path}${Platform.pathSeparator}MapTiles');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CacheStore>(
      future: _cacheStoreFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final cacheStore = snapshot.data!;
          log.fine(Platform.operatingSystem);
          return Scaffold(
            appBar: AppBar(title: const Text('Download Offline Map')),
            drawer: const MenuDrawer(DownloadOfflineMap.route),
            body: FlutterMap(
              options: MapOptions(
                initialCenter: const LatLng(1.29027, 103.851959),
                minZoom: 12,
                maxZoom: 20,
                cameraConstraint: CameraConstraint.containCenter(
                  bounds: LatLngBounds(
                    const LatLng(1.43327, 104.931959),
                    const LatLng(1.11027, 102.801959),
                  ),
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  tileProvider: CachedTileProvider(
                    // use the store for your CachedTileProvider instance
                    store: cacheStore,
                  ),
                ),
              ],
            ),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Download Offline Map')),
            drawer: const MenuDrawer(DownloadOfflineMap.route),
            body: Center(child: Text('Error: ${snapshot.error.toString()}')),
          );
        }
        return Scaffold(
          appBar: AppBar(title: const Text('Download Offline Map')),
          drawer: const MenuDrawer(DownloadOfflineMap.route),
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
