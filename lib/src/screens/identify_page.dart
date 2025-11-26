import 'package:flutter/material.dart';

class IdentifyPage extends StatelessWidget {
  final bool isSuccess;
  final String imageAsset;
  final String title;
  final String dateTime;

  const IdentifyPage({
    super.key,
    this.isSuccess = true,
    this.imageAsset = 'assets/images/Identify Page - Success Result.png',
    this.title = 'Untitled',
    this.dateTime = '2025-11-20 19:55',
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor = const Color(0xFFA6B79A);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 120,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Image.asset(
            'assets/images/Initial page.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: borderColor, width: 4),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      imageAsset,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(title, style: const TextStyle(fontSize: 14)),
                        const SizedBox(width: 6),
                        const Icon(Icons.edit, size: 16),
                      ],
                    ),
                    Text(dateTime, style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              Text(
                isSuccess ? 'MOLD DETECTED' : 'NO MOLD DETECTED',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: isSuccess ? Colors.red : Colors.grey[800],
                ),
              ),

              const SizedBox(height: 28),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: borderColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  elevation: 6,
                ),
                onPressed: () {
                  // Placeholder: save action or navigation
                  Navigator.of(context).pop();
                },
                child: const Text('Save & Continue', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
