import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mappls_gl/mappls_gl.dart';

class ProblemPage extends StatefulWidget {
  const ProblemPage({super.key});

  @override
  State<ProblemPage> createState() => _ProblemPageState();
}

class _ProblemPageState extends State<ProblemPage> {
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

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: const Color.fromRGBO(83, 101, 198, 1),
            title: Text(
              "Enter your problem",
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Container(
              height: 230,
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Text(
                    "Title",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Container(
                color: Colors.amber,
                child: TextButton(
                  onPressed: () {},
                  child: Text("Submit"),
                ),
              ),
            ],
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // color: Colors.cyan,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
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
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 30, top: 100),
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(83, 101, 198, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Got any ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "problem?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 50),
                  Text(
                    "Here are some mechanics near you",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: openDialog,
                    child: Text("problem"),
                  )
                ],
              ),
            ),
          ],
        ),
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
}
