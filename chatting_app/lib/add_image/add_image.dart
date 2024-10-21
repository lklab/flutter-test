import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {
  final Function(File pickedImage) addImageFunc;

  const AddImage(
    this.addImageFunc, {
    super.key
  });

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  File? _pickedImage;

  void _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 150,
    );

    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });

      widget.addImageFunc(_pickedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 300,
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue,
            backgroundImage: _pickedImage != null ? FileImage(_pickedImage!) : null,
          ),
          SizedBox(height: 10,),
          OutlinedButton.icon(
            onPressed: _pickImage,
            icon: Icon(Icons.image),
            label: Text('Add icon'),
          ),
          SizedBox(height: 80,),
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
            label: Text('Close'),
          ),
        ],
      ),
    );
  }
}
