import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';


import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Convert_Lat_Long(),
    );
  }
}




class Convert_Lat_Long extends StatefulWidget {
  const Convert_Lat_Long({Key? key}) : super(key: key);

  @override
  _Convert_Lat_LongState createState() => _Convert_Lat_LongState();
}

class _Convert_Lat_LongState extends State<Convert_Lat_Long> {
  // on below line we have created controllers for accessing values from textfield
  TextEditingController latitudeController = new TextEditingController();
  TextEditingController longitudeController = new TextEditingController();

  // variable created to store the address
  String stAddress = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // on below line we have given title of App
        title: Text('Current Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Get Address from Coordinates',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(height: 10),

              // textfield1 for taking input as latitude
              TextField(
                controller: latitudeController,
                decoration: InputDecoration(
                  // Given Hint Text
                    hintText: 'Latitude',
                    border: OutlineInputBorder(
                      // Given border to textfield
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              SizedBox(height: 10),

              // textfield2 for taking input as longitude
              TextField(
                controller: longitudeController,
                decoration: InputDecoration(
                  // Given hint text
                    hintText: 'Longitude',
                    border: OutlineInputBorder(
                      // given border to textfield
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              SizedBox(height: 10),

              // Given padding to the Container
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Center(
                    child: Text(stAddress),
                  ),
                ),
              ),
              SizedBox(height: 10),

              GestureDetector(
                onTap: () async {
                  // stored the value of latitude in lat from textfield
                  String lat = latitudeController.text;
                  // stored the value of longitude in lon from textfield
                  String lon = longitudeController.text;

                  // converted the lat from string to double
                  double lat_data = double.parse(lat);
                  // converted the lon from string to double
                  double lon_data = double.parse(lon);

                  // Passed the coordinates of latitude and longitude
                  final coordinates = Coordinates(lat_data, lon_data);
                  var address = await Geocoder.local
                      .findAddressesFromCoordinates(coordinates);
                  var first = address.first;

                  // on below line we have set the address to string
                  setState(() {
                    stAddress = first.addressLine.toString();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      // specified color for button
                      color: Colors.blue,
                    ),
                    // given height for button
                    height: 50,
                    child: Center(
                      // on below line we have given button name
                      child: Text(
                        'Convert',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
