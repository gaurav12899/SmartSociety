import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VendorImagePicker extends StatefulWidget {
  final void Function(File _pickedImage) imagePickFn;
  VendorImagePicker(this.imagePickFn);
  @override
  _VendorImagePickerState createState() => _VendorImagePickerState();
}

class _VendorImagePickerState extends State<VendorImagePicker> {
  File _image;

  final _imagePicker = ImagePicker();
  Future _imgFromCamera() async {
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

  Future _imgFromGallery() async {
    final _pickedFile = await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);
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
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.center,
          height: 100,
          width: 100,
          margin: EdgeInsets.only(top: 8, right: 10),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _image == null ? Text("Enter a Url ") : Image.file(_image),
        ),
        DropdownButton(
          hint: Text("Add image"),
          dropdownColor: Colors.lightGreen,
          items: [
            DropdownMenuItem(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Camera", style: TextStyle(color: Colors.white)),
                    Icon(Icons.camera, color: Colors.white)
                  ]),
              value: 0,
            ),
            DropdownMenuItem(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Gallery",
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.image,
                      color: Colors.white,
                    )
                  ]),
              value: 1,
            )
          ],
          onChanged: (value) {
            if (value == 0) {
              _imgFromCamera();
            } else {
              _imgFromGallery();
            }
          },
        )
      ],
    ));
  }
}
