import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import '../helpers/ensure-visible.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  Uri _staticMapUri;
  final FocusNode _addressInputFocusNode = FocusNode();

  @override
  void initState() {
    _addressInputFocusNode.addListener(_updateLocation);
    getStaticMap();
    super.initState();
  }

  @override
  void dispose() {
    _addressInputFocusNode.removeListener(_updateLocation);
    super.dispose();
  }

  void getStaticMap() {
    final StaticMapProvider staticMapProvider =
        StaticMapProvider('AIzaSyCIHplniutEkX2Yn8Ee8G01ASJduOmHnxo');
    final Uri staticMapUri = staticMapProvider.getStaticUriWithMarkers([
      Marker('position', 'Position', 41.40338, 2.17403),
    ],
        center: Location(32.23344, 1.23344),
        width: 500,
        height: 300,
        maptype: StaticMapViewType.roadmap);
    setState(() {
      _staticMapUri = staticMapUri;
    });
  }

  void _updateLocation() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        EnsureVisibleWhenFocused(
          focusNode: _addressInputFocusNode,
          child: TextFormField(),
        ),
        SizedBox(
          height: 10.0,
        ),
        Image.network(_staticMapUri.toString())
      ],
    );
  }
}
