import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // -------------------------
  //  UPLOAD IMAGE
  // -------------------------
  Future<String> uploadImage(
      String folder, String fileName, Uint8List bytes) async {
    try {
      final ref = _storage.ref().child('$folder/$fileName');

      await ref.putData(
        bytes,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print("Upload error: $e");
      return "";
    }
  }

  // -------------------------
  //  GET IMAGES FROM FIRESTORE
  // -------------------------
  Future<List<Map<String, dynamic>>> getDetections() async {
    try {
      final snapshot = await _db.collection('detections').get();

      return snapshot.docs
          .map((doc) => doc.data())
          .toList();
    } catch (e) {
      print("Error fetching detections: $e");
      return [];
    }
  }
}
