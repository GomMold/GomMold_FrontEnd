import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({super.key});

  static const _logoAsset = 'assets/images/Initial page.png';
  static const _mainImage = 'assets/images/Image Page.png';

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFF94A281);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header row with logo and close button
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

            // Title
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

            // Main image framed with rounded border
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: borderColor, width: 6),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  _mainImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),

            const SizedBox(height: 48),

            // Action buttons row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _RoundedAction(
                    onTap: () {},
                    child: const Icon(Icons.add_box_outlined, size: 34, color: Color(0xFF0E1220)),
                  ),
                  _RoundedAction(
                    onTap: () {},
                    child: const Icon(Icons.camera_alt_outlined, size: 34, color: Color(0xFF0E1220)),
                  ),
                ],
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
          color: const Color.fromRGBO(236, 239, 232, 1), // light rounded bg
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(color: Color(0x22000000), offset: Offset(0, 4), blurRadius: 6),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}
