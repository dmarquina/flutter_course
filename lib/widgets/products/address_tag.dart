import 'package:flutter/material.dart';
import 'package:flutter_course/models/location_data.dart';
import 'package:map_view/map_view.dart';

class LocationTag extends StatelessWidget {
  final LocationData productLocation;

  LocationTag(this.productLocation);

  void _showMap() {
    final List<Marker> markers = <Marker>[
      Marker('position', 'Position', productLocation.latitude, productLocation.longitude,
          color: Colors.green)
//          markerIcon: MarkerIcon('assets/food.jpg', height: 80.0, width: 80.0))
    ];
    final cameraPosition =
        CameraPosition(Location(productLocation.latitude, productLocation.longitude), 14.0);
    final mapView = MapView();
    mapView.show(
        MapOptions(
            initialCameraPosition: cameraPosition,
            mapViewType: MapViewType.normal,
            title: 'Product Location'),
        toolbarActions: [ToolbarAction('Close', 1)]);
    mapView.onToolbarAction.listen((int id) {
      if (id == 1) {
        mapView.dismiss();
      }
    });
    mapView.onMapReady.listen((_) {
      mapView.setMarkers(markers);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showMap,
      child: Container(
          alignment: Alignment(-1.0, 0.0),
          padding: EdgeInsets.only(top: 5.0),
          child: Text(productLocation.address)),
    );
  }
}
