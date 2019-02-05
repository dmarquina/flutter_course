import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_course/models/location_data.dart';
import 'package:flutter_course/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:map_view/map_view.dart';

import '../helpers/ensure-visible.dart';
import 'package:location/location.dart' as geoloc;

class LocationInput extends StatefulWidget {
  final Function setLocation;
  final Product product;

  LocationInput(this.setLocation, this.product);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  Uri _staticMapUri;
  LocationData _locationData;
  final FocusNode _addressInputFocusNode = FocusNode();
  final TextEditingController _addressInputController = TextEditingController();

  @override
  void initState() {
    _addressInputFocusNode.addListener(_updateLocation);
    if (widget.product != null) {
      _getStaticMap(widget.product.location.address, geocode: false);
    }
    super.initState();
  }

  @override
  void dispose() {
    _addressInputFocusNode.removeListener(_updateLocation);
    super.dispose();
  }

  void _getStaticMap(String address, {geocode = true, double lat, double lng}) async {
    if (address.isEmpty) {
      setState(() {
        _staticMapUri = null;
      });
      widget.setLocation(null);
      return;
    }
    if (geocode) {
      final Uri uri = Uri.https('maps.googleapis.com', '/maps/api/geocode/json',
          {'address': address, 'key': 'AIzaSyCIHplniutEkX2Yn8Ee8G01ASJduOmHnxo'});
      final http.Response response = await http.get(uri);
      final decodedResponse = json.decode(response.body);
      final formattedAddress = decodedResponse['results'][0]['formatted_address'];
      final cords = decodedResponse['results'][0]['geometry']['location'];
      _locationData =
          LocationData(address: formattedAddress, latitude: cords['lat'], longitude: cords['lng']);
    } else if (lat == null && lng == null) {
      _locationData = widget.product.location;
    } else {
      _locationData = LocationData(address: address, latitude: lat, longitude: lng);
    }
    final StaticMapProvider staticMapProvider =
        StaticMapProvider('AIzaSyCIHplniutEkX2Yn8Ee8G01ASJduOmHnxo');
    final Uri staticMapUri = staticMapProvider.getStaticUriWithMarkers([
      Marker('position', 'Position', _locationData.latitude, _locationData.longitude),
    ],
        center: Location(_locationData.latitude, _locationData.longitude),
        width: 500,
        height: 300,
        maptype: StaticMapViewType.roadmap);
    widget.setLocation(_locationData);
    if (mounted) {
      setState(() {
        _addressInputController.text = _locationData.address;
        _staticMapUri = staticMapUri;
      });
    }
  }

  Future<String> _getAddress(double lat, double lng) async {
    final uri = Uri.https('maps.googleapis.com', '/maps/api/geocode/json', {
      'latlng': '${lat.toString()},${lng.toString()}',
      'key': 'AIzaSyCIHplniutEkX2Yn8Ee8G01ASJduOmHnxo'
    });
    final http.Response response = await http.get(uri);
    final decodedResponse = json.decode(response.body);
    final formattedAddress = decodedResponse['results'][0]['formatted_address'];
    return formattedAddress;
  }

  void _getUserLocation() async {
    final location = geoloc.Location();
    final currentLocation = await location.getLocation();
    final address = await _getAddress(currentLocation['latitude'], currentLocation['longitude']);
    _getStaticMap(address,
        geocode: false, lat: currentLocation['latitude'], lng: currentLocation['longitude']);
  }

  void _updateLocation() {
    if (!_addressInputFocusNode.hasFocus) {
      _getStaticMap(_addressInputController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        EnsureVisibleWhenFocused(
          focusNode: _addressInputFocusNode,
          child: TextFormField(
            focusNode: _addressInputFocusNode,
            controller: _addressInputController,
            validator: (String value) {
              if (_locationData == null || value.isEmpty) {
                return 'Ubicación valida no encontrada';
              }
            },
            decoration: InputDecoration(labelText: 'Dirección'),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        FlatButton(child: Text('Localizar usuario'), onPressed: _getUserLocation),
        SizedBox(
          height: 10.0,
        ),
        _staticMapUri == null ? Container() : Image.network(_staticMapUri.toString())
      ],
    );
  }
}
