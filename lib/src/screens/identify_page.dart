import 'dart:io';
import 'package:flutter/material.dart';
//import '../services/api_service.dart';

class IdentifyPage extends StatefulWidget {
  final String imagePath;        // file path OR network URL
  final String title;
  final String dateTime;
  final String status;           // “MOLD DETECTED” / “NO MOLD DETECTED”
  final double confidence;       // backend %
  final String analysisId;       // used for updating

  const IdentifyPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.dateTime,
    required this.status,
    required this.confidence,
    required this.analysisId,
  });

  @override
  State<IdentifyPage> createState() => _IdentifyPageState();
}

class _IdentifyPageState extends State<IdentifyPage> {
  late String editedTitle;
  //bool _updating = false;

  @override
  void initState() {
    super.initState();
    editedTitle = widget.title;
  }

  /// -----------------------------------------------------------------
  /// EDIT TITLE POPUP → Save into backend
  /// -----------------------------------------------------------------
  void _renameAnalysis() {
    final controller = TextEditingController(text: editedTitle);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Rename Analysis"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: "New title",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("Save"),
            onPressed: () async {
              Navigator.pop(context);

              if (controller.text.trim().isEmpty) return;

              setState(() => editedTitle = controller.text.trim());
              // TODO: call update endpoint when available
            },
          ),
        ],
      ),
    );
  }

  Widget _loadImage(String path) {
    if (path.startsWith("http")) {
      return Image.network(path, fit: BoxFit.cover);
    } else {
      return Image.file(File(path), fit: BoxFit.cover);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color borderColor = const Color(0xFFA6B79A);
    final bool moldDetected = widget.status.toUpperCase().contains("DETECTED");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 120,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 8),

              const Text(
                'Result Analysis',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 24),

              /// IMAGE FRAME
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: borderColor, width: 4),
                ),
                clipBehavior: Clip.hardEdge,
                height: 180,
                width: double.infinity,
                child: _loadImage(widget.imagePath),
              ),

              const SizedBox(height: 16),

              /// TITLE & DATE ROW
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        editedTitle,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: _renameAnalysis,
                        child: const Icon(Icons.edit, size: 16),
                      ),
                    ],
                  ),
                  Text(widget.dateTime, style: const TextStyle(fontSize: 14)),
                ],
              ),

              const SizedBox(height: 30),

              /// RESULT STATUS
              Text(
                moldDetected ? "MOLD DETECTED" : "NO MOLD DETECTED",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: moldDetected ? Colors.red : Colors.black87,
                ),
              ),

              const SizedBox(height: 8),

              /// CONFIDENCE %
              Text(
                "Confidence: ${widget.confidence.toStringAsFixed(1)}%",
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),

              const SizedBox(height: 36),

              /// SAVE BUTTON
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: borderColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  elevation: 6,
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Save & Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
