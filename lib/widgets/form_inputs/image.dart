import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  void _getImage(BuildContext context, ImageSource source) {
    ImagePicker.pickImage(source: source, maxWidth: 400.0).then((File image) {
      Navigator.pop(context);
    });
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 180.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Elige una foto',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text('Usar cámara'),
                  onPressed: () {
                    _getImage(context, ImageSource.camera);
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text('Usar galeria'),
                  onPressed: () {
                    _getImage(context, ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor = Theme.of(context).primaryColor;
    return Column(
      children: <Widget>[
        OutlineButton(
          borderSide: BorderSide(width: 2.0, color: buttonColor),
          onPressed: () {
            _openImagePicker(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.camera_alt, color: buttonColor),
              SizedBox(
                width: 5.0,
              ),
              Text('Add Image', style: TextStyle(color: buttonColor))
            ],
          ),
        )
      ],
    );
  }
}
