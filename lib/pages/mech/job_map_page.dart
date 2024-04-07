import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mappls_gl/mappls_gl.dart';
import 'package:yantrik/components/navbar.dart';

class JobMapPage extends StatefulWidget {
  const JobMapPage({super.key});

  @override
  State<JobMapPage> createState() => _JobMapPageState();
}

class _JobMapPageState extends State<JobMapPage> {
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

  static const List<(Color?, Color? background, ShapeBorder?)> customizations =
      <(Color?, Color?, ShapeBorder?)>[
    (null, null, null), // The FAB uses its default for null parameters.
    (null, Colors.green, null),
    (Colors.white, Colors.green, null),
    (Colors.white, Colors.green, CircleBorder()),
  ];
  int index = 0;

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
            addPolyline();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) => Navbar()));
          });
        },
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(83, 101, 198, 1),
        shape: CircleBorder(),
        child: const Icon(Icons.navigation),
      ),
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

  void addPolyline() async {
    List<LatLng> latlng = const <LatLng>[
      LatLng(28.705436, 77.100462),
      LatLng(28.705191, 77.100784),
      LatLng(28.704646, 77.101514),
      LatLng(28.704194, 77.101171),
      LatLng(28.704083, 77.101066),
      LatLng(28.703900, 77.101318),
    ];
    LatLngBounds latLngBounds = boundsFromLatLngList(latlng);
    mapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds));
    mapController.addLine(
        LineOptions(geometry: latlng, lineColor: "#3bb2d0", lineWidth: 4));
  }

  boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null || x1 == null || y0 == null || y1 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
        northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
  }
}
