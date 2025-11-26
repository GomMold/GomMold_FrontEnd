import 'package:flutter/material.dart';

class ChatBotPage extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String subtitle;

  const ChatBotPage({
    super.key,
    this.imageAsset = 'assets/images/ChatBot.png',
    this.title = 'Chat with GOMMOLD',
    this.subtitle = 'Tap start to begin identification assistant',
  });

  @override
  Widget build(BuildContext context) {
    final Color accent = const Color(0xFFA6B79A);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 120,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Image.asset('assets/images/Initial page.png', fit: BoxFit.contain),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 28),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, 4)),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    imageAsset,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: accent,
                  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: () {
                  // Placeholder action: navigate to chat or trigger assistant
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Start Chat pressed')));
                },
                child: const Text('Start Chat', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),

              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close', style: TextStyle(color: Colors.black54)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
