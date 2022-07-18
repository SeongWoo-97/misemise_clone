import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:misemise_clone/Class/StationOnMapProvider.dart';
import 'package:provider/provider.dart';

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class MiseMiseMap extends StatefulWidget {
  const MiseMiseMap({Key? key}) : super(key: key);

  @override
  _MiseMiseMapState createState() => _MiseMiseMapState();
}

class _MiseMiseMapState extends State<MiseMiseMap> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(36.0608923071516, 129.38002726495608),
    zoom: 11,
  );
  List<Marker> _markers = [];
  late StationOnMapProvider stationOnMapProvider = Provider.of<StationOnMapProvider>(context, listen: false);
///////////////
  final GlobalKey genKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    stationOnMapProvider.stationOnMap.keys.forEach((element) {
      double latitude = double.parse('${stationOnMapProvider.stationOnMap["$element"]?.stationCoord?.dmY}');
      double longitude = double.parse('${stationOnMapProvider.stationOnMap["$element"]?.stationCoord?.dmX}');
      print('$latitude,$longitude');
      _markers.add(
        Marker(
          markerId: MarkerId(element),
          position: LatLng(longitude, latitude),
          infoWindow: InfoWindow(
            title: 'title',
            snippet: 'snippet',
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers.toSet(),
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        rotateGesturesEnabled: false, // 회전 여부
      ),
    );
  }
  Future<void> takePicture() async {
    RenderRepaintBoundary boundary = genKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
    Uint8List pngBytes = byteData.buffer.asUint8List();
    File imgFile = new File('$directory/photo.png');
    imgFile.writeAsBytes(pngBytes);
  }
}
