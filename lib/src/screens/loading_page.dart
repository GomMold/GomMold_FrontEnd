import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [

            // ---------- TOP IMAGE/LOGO ----------
            Expanded(
              child: Center(
                child: Container(
                  width: 324,
                  height: 375,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.62),
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage("assets/images/Loading_page.png"), // replace with your actual image
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // ---------- COPYRIGHT ----------
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                'Copyright© 2025 Gom.Inc. All rights reserved.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF253E05),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            // ---------- BOTTOM HANDLE (IPHONE STYLE) ----------
            Container(
              height: 34,
              alignment: Alignment.center,
              child: Container(
                width: 134,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

