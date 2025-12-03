import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/api_service.dart';
import 'identify_page.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  static const _logoAsset = 'assets/images/logo.png';
  static const borderColor = Color(0xFF94A281);

  File? _selectedImage;
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();

  /// ────────────────────────────────────────────────
  /// Pick image (camera or gallery)
  /// ────────────────────────────────────────────────
  Future<void> _pickImage(ImageSource source) async {
    final file = await _picker.pickImage(source: source, imageQuality: 85);
    if (file != null) {
      setState(() {
        _selectedImage = File(file.path);
      });
    }
  }

  /// ────────────────────────────────────────────────
  /// Upload image → detect mold
  /// ────────────────────────────────────────────────
  Future<void> _analyzeImage() async {
  if (_selectedImage == null) {
    _showSnack("Please select an image first.");
    return;
  }

  setState(() => _isLoading = true);

  final response = await ApiService().detectMold(
    _selectedImage!,
    "User Analysis", // default
  );

  setState(() => _isLoading = false);

  if (response.statusCode == 200 && response.data != null) {
    final data = response.data;

   Navigator.push(
   context,
   MaterialPageRoute(
    builder: (_) => IdentifyPage(
      imagePath: _selectedImage!.path,
      analysisName: data["analysis_name"] ?? "Untitled",
      timestamp: data["timestamp"]?? "",
      message: data["message"]?? "No message",
      status: data["result"]?? "safe",
      analysisId: data["id"]?? "",  
      ),
    ),
  );

  } else {
    _showSnack(response.message ?? "Failed to analyze image");
  }
}

  
  //_showSnack() is used to show toast-like pop-up messages at the bottom of the screen, using Flutter’s SnackBar

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  /// ────────────────────────────────────────────────
  /// UI
  /// ────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// Header row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    _logoAsset,
                    width: 100,
                    height: 36,
                    fit: BoxFit.contain,
                  ),
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(Icons.close, size: 24),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// Title
            const Text(
              'Mold Identifier',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 18),

            /// Image Frame
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: borderColor, width: 6),
                ),
                clipBehavior: Clip.hardEdge,
                child: _selectedImage == null
                      ? Container(
                       color: const Color(0xFFECEFE8),
                       child: const Center(
                       child: Icon(Icons.image_outlined,
                       size: 60, color: Color(0xFF94A281)),
                       ),
                   )
                    : Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                      ),
              ),
            ),

            const SizedBox(height: 48),

            /// Buttons row: gallery + camera
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _RoundedAction(
                    onTap: () => _pickImage(ImageSource.gallery),
                    child: const Icon(Icons.add_box_outlined,
                        size: 34, color: Color(0xFF0E1220)),
                  ),
                  _RoundedAction(
                    onTap: () => _pickImage(ImageSource.camera),
                    child: const Icon(Icons.camera_alt_outlined,
                        size: 34, color: Color(0xFF0E1220)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 42),

            /// Analyze Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _analyzeImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF94A281),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Analyze Now",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,       
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundedAction extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const _RoundedAction({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 76,
        height: 76,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(236, 239, 232, 1),
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              offset: Offset(0, 4),
              blurRadius: 6,
            ),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}
