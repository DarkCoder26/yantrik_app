import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yantrik/pages/mech/job_map_page.dart';

class MechHomePage extends StatefulWidget {
  const MechHomePage({super.key});

  @override
  State<MechHomePage> createState() => _MechHomePageState();
}

class _MechHomePageState extends State<MechHomePage> {
  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: const Color.fromRGBO(225, 225, 225, 1),
            content: Container(
              height: 230,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Type",
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "020 km",
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Description",
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("front tire punctured. ")
                ],
              ),
            ),
            actions: [
              Container(
                color: Color.fromRGBO(120, 87, 233, 1),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const JobMapPage()),
                    );
                  },
                  child: Text(
                    "Go",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 80, left: 35),
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromRGBO(83, 101, 198, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Incoming",
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Requests",
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            SingleChildScrollView(
              child: Container(
                // color: Colors.black,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      jobCard(context, "tyre puncture ", "0"),
                      jobCard(context, "battery jumpstart", "0"),
                      jobCard(context, "tow truck needed", "0"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector jobCard(
      BuildContext context, String problem, String distance) {
    return GestureDetector(
      onTap: openDialog,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: MediaQuery.of(context).size.width * 0.80,
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              problem,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${distance} km",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
