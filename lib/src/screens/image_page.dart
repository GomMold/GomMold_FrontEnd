import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import 'package:image_picker/image_picker.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  final _firebaseService = FirebaseService();
  List<String> _images = [];

  void _pickAndUploadImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final bytes = await picked.readAsBytes();
      final fileName = picked.name.isNotEmpty
          ? picked.name
          : DateTime.now().millisecondsSinceEpoch.toString();

      final url = await _firebaseService.uploadImage(
        'uploads',
        fileName,
        bytes,
      );

      if (url != null && url.isNotEmpty) {
        setState(() => _images.add(url));
      } else {
        debugPrint("Upload failed — URL is null");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Images')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickAndUploadImage,
            child: const Text('Upload Image'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(_images[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
