import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'identify_page.dart';

class HomepageTime extends StatefulWidget {
  const HomepageTime({super.key});

  @override
  State<HomepageTime> createState() => _HomepageTimeState();
}

class _HomepageTimeState extends State<HomepageTime> {
  bool _isLoading = true;
  List<dynamic> _history = [];

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  /// ---------------------------------------------------------
  /// FETCH HISTORY FROM BACKEND
  /// ---------------------------------------------------------
  Future<void> _fetchHistory() async {
    setState(() => _isLoading = true);

    final response = await ApiService().getHistory();

    if (response.statusCode == 200 && response.data != null) {
      setState(() {
        _history = response.data; 
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
      print("Error fetching history: ${response.message}");
    }
  }

  /// ---------------------------------------------------------
  /// HISTORY ITEM UI
  /// ---------------------------------------------------------
  Widget _buildHistoryItem(int index) {
  final item = _history[index];
  final isMold = item["result"] == "warning";

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color.fromARGB(84, 148, 162, 129),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      children: [
        // -------------------------
        // CLICKABLE TITLE
        // -------------------------
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => IdentifyPage(
                    imagePath: item["image_url"],
                    analysisName: item["analysis_name"],
                    timestamp: item["timestamp"],
                    message: item["message"],
                    status: item["result"],
                    analysisId: item["id"],
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${index + 1}. ${item["analysis_name"] ?? "Untitled"}',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue, // clickable
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item["message"] ?? "",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isMold ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),

        // TIME
        Text(
          item["timestamp"] ?? "",
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}


  /// ---------------------------------------------------------
  /// BUILD UI
  /// ---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF94A281)),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),

                      /// Logo + Subtitle
                      Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/logo.png',
                              width: 170,
                              height: 80,
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

                      /// Title
                      const Text(
                        "History",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// History Items
                      _history.isEmpty
                          ? const Center(
                              child: Text(
                                "No history yet.",
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          : Column(
                              children: List.generate(
                                _history.length,
                                (index) => Padding(
                                  padding: EdgeInsets.only(
                                    bottom: index == _history.length - 1
                                        ? 8
                                        : 20,
                                  ),
                                  child: _buildHistoryItem(index),
                                ),
                              ),
                            ),

                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
      ),

      /// ---------------------------------------------------------
      /// BOTTOM NAVIGATION BAR
      /// ---------------------------------------------------------
      bottomNavigationBar: Container(
        height: 78,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x1A000000),
              offset: Offset(0, -0.5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/chatbot'),
              icon: Image.asset(
              'assets/images/chatbot_icon.png',
               width: 33,
               height: 33,
               ),
            ),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 1),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/image');
                },
                icon: const Icon(Icons.camera_alt_outlined, size: 28),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              icon: const Icon(Icons.settings_outlined, size: 28),
            ),
          ],
        ),
      ),
    );
  }
}
