import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Loading state
  bool _isLoading = false;

  // Services
  final ApiService _apiService = ApiService();
  final AuthService _authService = AuthService();

  // Login function
  void _login() async {
    setState(() => _isLoading = true);

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final resp = await _apiService.login(email, password);

    setState(() => _isLoading = false);

    if (resp['statusCode'] == 200) {
      final token = resp['body']['data']['token'];
      final user = resp['body']['data']['user'];

      await _authService.saveToken(token);
      await _authService.saveUser(user);

      Navigator.pushReplacementNamed(context, '/home');
    } else {
      final msg = resp['body']['message'] ?? 'Login failed';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
            ),

            // --- Header image/logo ---
            Positioned(
              left: 24,
              top: 196,
              child: Container(
                width: 318,
                height: 115,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.62),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 24,
                      top: 12,
                      child: Container(
                        width: 245,
                        height: 66,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("https://placehold.co/245x66"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 55,
                      top: 78,
                      child: const SizedBox(
                        width: 184,
                        height: 25,
                        child: Text(
                          'AI- Driven Mold Detection',
                          style: TextStyle(
                            color: Color(0xFF253E05),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- Page Title ---
            const Positioned(
              left: 52,
              top: 259,
              child: Text(
                'Log In',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            // --- Subtitle ---
            const Positioned(
              left: 52,
              top: 290,
              child: Text(
                'Enter your credentials to access GomMold',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            // --- Email Label ---
            const Positioned(
              left: 57,
              top: 324,
              child: Text(
                'Email',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                ),
              ),
            ),

            // --- Email Input ---
            Positioned(
              left: 35,
              top: 360,
              child: SizedBox(
                width: 261,
                height: 43,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),

            // --- Password Label ---
            const Positioned(
              left: 54,
              top: 430,
              child: Text(
                'Password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                ),
              ),
            ),

            // --- Password Input ---
            Positioned(
              left: 35,
              top: 465,
              child: SizedBox(
                width: 261,
                height: 43,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),

            // --- Login Button ---
            Positioned(
              left: 35,
              top: 530,
              child: SizedBox(
                width: 261,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
            ),

            // --- Sign Up Link ---
            Positioned(
              left: 99,
              top: 613,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don’t have an account? ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w800,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // --- Copyright ---
            const Positioned(
              left: 46,
              top: 730,
              child: Text(
                'Copyright© 2025 Gom.Inc. All rights reserved.',
                style: TextStyle(
                  color: Color(0xFF253E05),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
