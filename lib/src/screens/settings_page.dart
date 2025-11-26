import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final String imageAsset;
  final String username;
  final String password;
  final String email;
  final String appVersion;
  final String deviceInfo;

  const SettingsPage({
    Key? key,
    this.imageAsset = 'assets/images/Settings .png',
    this.username = 'Coolat',
    this.password = '************',
    this.email = 'coolat@gmail.com',
    this.appVersion = '1.0.0',
    this.deviceInfo = 'Iphone 14Pro, IOS 26',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = const Color(0xFFA6B79A);
    final Color borderColor = const Color(0xFFE6E6E6);
    final Color labelColor = Colors.black;

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
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Column(
            children: [
              // Account Information Section
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
                        Text(
                          'Account Information',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: labelColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildSettingItem('Username:', username, showEditIcon: true),
                    const SizedBox(height: 12),
                    _buildSettingItem('Password:', password),
                    const SizedBox(height: 12),
                    _buildSettingItem('Email:', email),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // About GomMold Section
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
                        Icon(Icons.info_outline, color: primaryGreen, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'About GomMold',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: labelColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildSettingItem('App Version:', appVersion),
                    const SizedBox(height: 12),
                    _buildSettingItem('Device :', deviceInfo),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Sign Out Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 4,
                ),
                onPressed: () {
                  // Placeholder: navigate to login or clear session
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sign Out pressed')),
                  );
                  Navigator.of(context).pop();
                },
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

  Widget _buildSettingItem(String label, String value, {bool showEditIcon = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            if (showEditIcon)
              const Icon(Icons.edit, size: 14, color: Colors.black54),
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
