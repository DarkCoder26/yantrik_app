import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mappls_gl/mappls_gl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    MapplsAccountManager.setMapSDKKey("c7a2a5bd8ae87ecf8b246bb6c94abe95");
    MapplsAccountManager.setRestAPIKey("c7a2a5bd8ae87ecf8b246bb6c94abe95");
    MapplsAccountManager.setAtlasClientId(
        "96dHZVzsAuv4_F11oBYHX4pvY9N38BjH5WwHx3InCSx3g7hewhTM_pTHffxpXDJDRHYhCDDa1Fs7kj_8FSMdiQ==");
    MapplsAccountManager.setAtlasClientSecret(
        "lrFxI-iSEg9VaL5Gljbnc8r8MugQdFGzXgg5Ji6x-iC8xc-BpwAtROha0KlpH-dDqUxHctJSiUVWHheiU_-xmRHKm7eP-UYI");
    getCurrentLocation();
  }

  getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("Location Denied !!");
      LocationPermission ask = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      print(
          'Latitude : ${currentPosition.latitude.toString()}, Longitude : ${currentPosition.longitude.toString()}');
    }
  }

  late MapplsMapController mapController;
  TextEditingController locationController = TextEditingController();

  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(28.3581380530955, 75.58258278901951),
    zoom: 14.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          // color: Colors.cyan,
          child: MapplsMap(
            initialCameraPosition: _kInitialPosition,
            myLocationEnabled: true,
            myLocationTrackingMode: MyLocationTrackingMode.Tracking,
            onUserLocationUpdated: (location) {
              print('onUserLocationUpdated ${location.position.toJson()}');
            },
            onStyleLoadedCallback: () {
              addMarker();
            },
          )),
    );
  }

  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }

  void addMarker() async {
    await addImageFromAsset("icon", "assets/locmaker.png");
    mapController.addSymbol(const SymbolOptions(
        geometry: LatLng(28.35778988630296, 75.58279199607256),
        iconImage: "icon"));
  }
}
