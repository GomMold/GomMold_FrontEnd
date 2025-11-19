import 'package:flutter/material.dart';
import '../services/api_service.dart';

class IdentifyPage extends StatefulWidget {
  const IdentifyPage({super.key});

  @override
  State<IdentifyPage> createState() => _IdentifyPageState();
}

class _IdentifyPageState extends State<IdentifyPage> {
  final ApiService _api = ApiService();
  List<dynamic> _detections = [];
  bool _loading = true;

  Future<void> _loadDetections() async {
    final result = await _api.getHistory();

    setState(() {
      _loading = false;
      if (result["statusCode"] == 200) {
        _detections = result["body"];     // <-- List from backend
      } else {
        _detections = [];
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadDetections();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Identify History')),

      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _detections.isEmpty
              ? const Center(
                  child: Text(
                    "No detections yet.",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  itemCount: _detections.length,
                  itemBuilder: (context, index) {
                    final item = _detections[index];

                    return Card(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        title: Text(item['moldType'] ?? 'Unknown Mold'),
                        subtitle:
                            Text(item['confidence']?.toString() ?? 'No confidence'),
                        trailing: Text(item['date'] ?? ''),
                      ),
                    );
                  },
                ),
    );
  }
}
