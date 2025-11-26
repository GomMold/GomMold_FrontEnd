import 'package:flutter/material.dart';

class HomepageTime extends StatelessWidget {
  const HomepageTime({super.key});

  static const _logoAsset = 'assets/images/Initial page.png';
  static const _itemBg = Color.fromARGB(84, 148, 162, 129); // rgba(148,162,129,0.33)

  final List<Map<String, String>> _history = const [
    {'title': "Coolat’s room", 'date': '2025-11-20 19:55'},
    {'title': 'Kitchen Wall', 'date': '2025-11-18 16:02'},
    {'title': 'Bathroom Walls', 'date': '2025-11-15 12:25'},
    {'title': 'Furniture', 'date': '2025-11-13 00:03'},
    {'title': 'Windows Sill', 'date': '2025-11-10 09:17'},
  ];

  Widget _buildHistoryItem(BuildContext context, int index) {
    final item = _history[index];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: _itemBg,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '${index + 1}. ${item['title']}',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            item['date']!,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        _logoAsset,
                        width: 170,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'AI- Driven Mold Detection',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: Color(0xFF253F05),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  'History',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                // History list
                Column(
                  children: List.generate(
                    _history.length,
                    (i) => Padding(
                      padding: EdgeInsets.only(bottom: i == _history.length - 1 ? 8 : 20),
                      child: _buildHistoryItem(context, i),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
      // Bottom navigation bar (simple reproduction of Figma tab bar)
      bottomNavigationBar: Container(
        height: 78,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Color(0x1A000000), offset: Offset(0, -0.5))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.chat_bubble_outline, size: 28),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 1),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.camera_alt_outlined, size: 28),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings_outlined, size: 28),
            ),
          ],
        ),
      ),
    );
  }
}
