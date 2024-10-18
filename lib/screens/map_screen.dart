import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.red,
      body: GoogleMap(
        onMapCreated: (controller) {
          print('Map Created');
         
        },
        padding: const EdgeInsets.only(bottom: 100),
        onLongPress: (latLong) => print('lat: ${latLong.latitude}, long: ${latLong.longitude}'),
          initialCameraPosition:
             const CameraPosition(target: LatLng(18.149814495638118, -77.3208948969841), )),
    );
  }
}
