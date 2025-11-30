import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ChatbotInterfacePage extends StatefulWidget {
  const ChatbotInterfacePage({super.key});

  @override
  State<ChatbotInterfacePage> createState() => _ChatbotInterfacePageState();
}

class _ChatbotInterfacePageState extends State<ChatbotInterfacePage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadGreeting();
  }

  /// -------------------------------------------------
  /// LOAD GREETING: "Hi I'm Gom…"
  /// -------------------------------------------------
  Future<void> _loadGreeting() async {
    setState(() => _isLoading = true);

    final response = await ApiService().chatbotStart();

    setState(() => _isLoading = false);

    if (response.statusCode == 200 && response.data != null) {
      final greeting = response.data["message"] ?? "Hi! I'm Gom, your mold assistant.";
      _addMessage(greeting, false);
    } else {
      _addMessage("Failed to load greeting.", false);
    }
  }

  /// -------------------------------------------------
  /// SEND MESSAGE
  /// -------------------------------------------------
  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    _addMessage(text, true);
    _controller.clear();

    setState(() => _isLoading = true);

    final response = await ApiService().chatbotQuery(text);

    setState(() => _isLoading = false);

    if (response.statusCode == 200 && response.data != null) {
      final reply = response.data["reply"] ?? "Sorry, I didn't get that.";
      _addMessage(reply, false);
    } else {
      _addMessage("Error connecting to chatbot.", false);
    }
  }

  /// -------------------------------------------------
  /// ADD MESSAGE + AUTOSCROLL
  /// -------------------------------------------------
  void _addMessage(String text, bool isUser) {
    setState(() {
      _messages.add({"text": text, "isUser": isUser});
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  /// -------------------------------------------------
  /// CHAT UI BUBBLE
  /// -------------------------------------------------
  Widget _buildBubble(Map<String, dynamic> msg) {
    final isUser = msg["isUser"];
    final color = isUser ? const Color(0xFF94A281) : const Color(0xFFEAEFD3);

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          msg["text"],
          style: TextStyle(
            fontSize: 15,
            color: isUser ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  /// -------------------------------------------------
  /// MAIN UI
  /// -------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Gom", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (_, index) => _buildBubble(_messages[index]),
            ),
          ),

          if (_isLoading)
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: CircularProgressIndicator(color: Color(0xFF94A281)),
            ),

          /// INPUT FIELD
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.black12)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Ask me anything about mold...",
                      filled: true,
                      fillColor: const Color(0xFFF2F2F2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: _isLoading ? null : _sendMessage,
                  icon: const Icon(Icons.send, size: 28),
                  color: const Color(0xFF253F05),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

