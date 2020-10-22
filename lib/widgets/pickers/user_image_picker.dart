import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File _pickedImage) imagePickFn;
  UserImagePicker(this.imagePickFn);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  final _imagePicker = ImagePicker();
  File _image;
  Future _pickImage() async {
    final _pickedFile = await _imagePicker.getImage(
        source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    setState(() {
      if (_pickedFile != null) {
        _image = File(_pickedFile.path);
        widget.imagePickFn(_image);
      } else {
        print("no image selected");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[200],
          backgroundImage: _image == null ? null : FileImage(_image),
          radius: 50,
        ),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: FittedBox(
            fit: BoxFit.cover,
            child: Text('Add Image'),
          ),
        ),
      ],
    );
  }
}
