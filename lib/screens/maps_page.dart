import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  Set<Marker> _markers = Set<Marker>();
  Set<Polyline> _polylines = Set<Polyline>();

  @override
  void initState() {
    super.initState();

    // This is the driver's location and delivery location
    LatLng driverLocation = const LatLng(6.605874, 3.349149);
    LatLng deliveryLocation = const LatLng(6.4999, 4.11667);

    //This is markers for the driver and delivery locations
    _markers.add(Marker(
      markerId: const MarkerId("Driver"),
      position: driverLocation,
      infoWindow: const InfoWindow(title: "Driver's Location"),
    ));

    _markers.add(Marker(
      markerId: const MarkerId("Delivery"),
      position: deliveryLocation,
      infoWindow: const InfoWindow(title: "Delivery Location"),
    ));

    // Draw a polyline between the driver and delivery locations
    _polylines.add(Polyline(
      polylineId: const PolylineId("Path"),
      color: Colors.blue,
      width: 5,
      points: [driverLocation, deliveryLocation],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Path'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            _controller = controller;
          });
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(6.605874, 3.349149),
          zoom: 14.0,
        ),
        markers: _markers,
        polylines: _polylines,
      ),
    );
  }
}
