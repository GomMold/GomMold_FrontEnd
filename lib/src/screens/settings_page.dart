import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final ApiService _api = ApiService();
  final AuthService _auth = AuthService();

  String username = "";
  String email = "";
  String maskedPassword = "************";

  bool _loadingProfile = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  /// ---------------------------------------------------
  /// LOAD PROFILE FROM BACKEND
  /// ---------------------------------------------------
  Future<void> _loadProfile() async {
    final response = await _api.getProfile();

    if (response.statusCode == 200 && response.data != null) {
      setState(() {
        username = response.data["username"] ?? "";
        email = response.data["email"] ?? "";
        _loadingProfile = false;
      });
    } else {
      setState(() => _loadingProfile = false);
      _showSnack("Failed to load profile.");
    }
  }

  /// ---------------------------------------------------
  /// EDIT USERNAME POPUP
  /// ---------------------------------------------------
  void _editUsername() {
    final controller = TextEditingController(text: username);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Username"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: "New Username",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () async {
              final newName = controller.text.trim();
              if (newName.isEmpty) return;

              Navigator.pop(context);
              await _updateProfile(username: newName);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  /// ---------------------------------------------------
  /// EDIT PASSWORD POPUP
  /// ---------------------------------------------------
  void _editPassword() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Change Password"),
        content: TextField(
          controller: controller,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: "New Password",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          TextButton(
            onPressed: () async {
              final newPass = controller.text.trim();
              if (newPass.isEmpty) return;

              Navigator.pop(context);
              await _updateProfile(password: newPass);
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  /// ---------------------------------------------------
  /// UPDATE PROFILE
  /// ---------------------------------------------------
  Future<void> _updateProfile({String? username, String? password}) async {
    final response = await _api.updateProfile(username: username, password: password);

    if (response.statusCode == 200) {
      _showDialog("Profile updated successfully!");

      if (username != null) setState(() => this.username = username);
      if (password != null) setState(() => maskedPassword = "************");
    } else {
      _showSnack(response.message ?? "Update failed");
    }
  }

  /// ---------------------------------------------------
  /// LOGOUT
  /// ---------------------------------------------------
  Future<void> _logout() async {
    await _auth.deleteToken();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  /// UI helpers
  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _showDialog(String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Success"),
        content: Text(msg),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK")),
        ],
      ),
    );
  }

  /// ---------------------------------------------------
  /// UI MAIN
  /// ---------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = const Color(0xFFA6B79A);
    final Color borderColor = const Color(0xFFE6E6E6);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 120,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),

      body: _loadingProfile
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF94A281)))
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    /// -----------------------------
                    /// ACCOUNT INFORMATION
                    /// -----------------------------
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: borderColor, width: 1.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.account_circle, color: primaryGreen, size: 20),
                              const SizedBox(width: 8),
                              const Text(
                                'Account Information',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          /// Username
                          _buildSettingItem(
                            'Username:',
                            username,
                            showEditIcon: true,
                            onEdit: _editUsername,
                          ),

                          const SizedBox(height: 12),

                          /// Password
                          _buildSettingItem(
                            'Password:',
                            maskedPassword,
                            showEditIcon: true,
                            onEdit: _editPassword,
                          ),

                          const SizedBox(height: 12),

                          /// Email (not editable)
                          _buildSettingItem('Email:', email),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// -----------------------------
                    /// ABOUT SECTION
                    /// -----------------------------
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: borderColor, width: 1.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Row(
                            children: [
                              Icon(Icons.info_outline, color: Color(0xFFA6B79A), size: 20),
                              SizedBox(width: 8),
                              Text(
                                'About GomMold',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text('App Version: 1.0.0',
                              style: TextStyle(fontSize: 12, color: Colors.black54)),
                          SizedBox(height: 12),
                          Text('Device: iPhone 14 Pro, iOS 16',
                              style: TextStyle(fontSize: 12, color: Colors.black54)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    /// -----------------------------
                    /// LOG OUT BUTTON
                    /// -----------------------------
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: _logout,
                      child: const Text(
                        'Sign Out',
                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  /// ---------------------------------------------------
  /// REUSABLE ROW ITEM
  /// ---------------------------------------------------
  Widget _buildSettingItem(
    String label,
    String value, {
    bool showEditIcon = false,
    VoidCallback? onEdit,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            if (showEditIcon)
              GestureDetector(
                onTap: onEdit,
                child: const Icon(Icons.edit, size: 14, color: Colors.black54),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
