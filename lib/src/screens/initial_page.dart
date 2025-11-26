/*import 'package:flutter/material.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  static const _logoAsset = 'assets/images/Initial page.png';
  static const Color _pillColor = Color(0xFFA6B79A); // approximate

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            children: [
              const Spacer(flex: 3),

              // Logo (local asset)
              Center(
                child: Image.asset(
                  _logoAsset,
                  width: 280,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 20),

              // Get Started pill
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/login'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 12),
                    decoration: BoxDecoration(
                      color: _pillColor,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          offset: const Offset(0, 6),
                          blurRadius: 10,
                        ),
                        BoxShadow(
                          color: Colors.white.withOpacity(0.4),
                          offset: const Offset(0, -2),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: const Text(
                      'Get started',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  static const String _logoAsset = 'assets/images/logo.png';
  static const Color _pillColor = Color(0xFFA6B79A);

  @override
  Widget build(BuildContext context) {
    // Screen width
    final double screenWidth = MediaQuery.of(context).size.width;

    // Limit max width to mobile size for desktop & web
    final double contentWidth = screenWidth > 500 ? 430 : screenWidth;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: contentWidth,
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Responsive logo
                Image.asset(
                  _logoAsset,
                  width: contentWidth * 0.8,   // 80% of container width
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 40),

                // Get Started button
                GestureDetector(
                  onTap: () {
                     Navigator.pushNamed(context, '/login');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 16),
                    decoration: BoxDecoration(
                      color: _pillColor,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Text(
                      "Get started",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


