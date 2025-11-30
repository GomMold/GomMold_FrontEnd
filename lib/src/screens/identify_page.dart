import 'dart:io';
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class IdentifyPage extends StatefulWidget {
  final String imagePath;       // local path or URL
  final String analysisName;    // backend: analysis_name
  final String timestamp;       // backend: timestamp (formatted string)
  final String message;         // backend: "Mold detected" / "No mold detected"
  final String status;          // backend: "warning" / "safe"
  final String analysisId;      // firestore document ID

  const IdentifyPage({
    super.key,
    required this.imagePath,
    required this.analysisName,
    required this.timestamp,
    required this.message,
    required this.status,
    required this.analysisId,
  });

  @override
  State<IdentifyPage> createState() => _IdentifyPageState();
}

class _IdentifyPageState extends State<IdentifyPage> {
  late String editedTitle;

  @override
  void initState() {
    super.initState();
    editedTitle = widget.analysisName;
  }

  // LOAD IMAGE (local or URL)
  Widget _loadImage(String path) {
    if (path.startsWith("http")) {
      return Image.network(path, fit: BoxFit.cover);
    }
    return Image.file(File(path), fit: BoxFit.cover);
  }

  // POPUP FOR RENAMING ANALYSIS TITLE
  void _renameTitlePopup() {
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
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);

              final newName = controller.text.trim();
              if (newName.isEmpty) return;

              setState(() => editedTitle = newName);

              /// 🔥 UPDATE TITLE IN BACKEND FIRESTORE
              final result = await ApiService()
                  .updateAnalysisTitle(widget.analysisId, newName);

                  if (result.statusCode == 200) {
                    Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                  (route) => false,

               /*if (result.statusCode == 200) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Title updated successfully")),*/
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(result.message ?? "Failed to save title")),
                );
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //@override

  // 🔍 DEBUG PRINT — SEE WHICH VALUE IS NULL
    print("DEBUG >>> imagePath = ${widget.imagePath}");
    print("DEBUG >>> analysisName = ${widget.analysisName}");
    print("DEBUG >>> timestamp = ${widget.timestamp}");
    print("DEBUG >>> message = ${widget.message}");
    print("DEBUG >>> status = ${widget.status}");
    print("DEBUG >>> analysisId = ${widget.analysisId}");

    const Color borderColor = Color(0xFFA6B79A);

    // True if backend says "warning" → mold detected
    final bool moldDetected = widget.status == "warning";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 120,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 8),

              const Text(
                "Result Analysis",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              // IMAGE
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor, width: 4),
                  borderRadius: BorderRadius.circular(14),
                ),
                clipBehavior: Clip.hardEdge,
                child: _loadImage(widget.imagePath),
              ),

              const SizedBox(height: 16),

              // TITLE + TIMESTAMP
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _renameTitlePopup,
                    child: Row(
                      children: [
                        Text(
                          editedTitle,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.edit, size: 16),
                      ],
                    ),
                  ),
                  Text(widget.timestamp, style: const TextStyle(fontSize: 14)),
                ],
              ),

              const SizedBox(height: 30),

              // RESULT MESSAGE
              Text(
                widget.message.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: moldDetected ? Colors.red : Colors.green,
                ),
              ),

              const SizedBox(height: 36),

              // SAVE BUTTON → GO HOME
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: borderColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 6,
                ),
                child: const Text(
                  "Save & Continue",
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
