import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Screens
import 'src/screens/login_page.dart';
import 'src/screens/signup_page.dart';
import 'src/screens/home_page.dart';
import 'src/screens/initial_page.dart';
import 'src/screens/image_page.dart';
import 'src/screens/identify_page.dart';
import 'src/screens/gallery_page.dart';
import 'src/screens/chatbot_page.dart';
import 'src/screens/settings_page.dart';

// Services
import 'src/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: AuthService().isLoggedIn(),
      builder: (context, snapshot) {
        
        // Show loading indicator while checking login status
        if (!snapshot.hasData) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        final loggedIn = snapshot.data ?? false;

        return MaterialApp(
          title: 'GomMold',
          theme: ThemeData(primarySwatch: Colors.green),
          debugShowCheckedModeBanner: false,
          initialRoute: loggedIn ? '/home' : '/login',
          
          routes: {
            '/initial': (context) => const InitialPage(),
            '/login': (context) => const LoginPage(),
            '/signup': (context) => SignUpPage(),
            '/home': (context) => const HomePage(),

            '/image': (context) => ImagePage(),
            '/identify': (context) => IdentifyPage(),
            '/gallery': (context) => GalleryPage(),
            '/chatbot': (context) => ChatbotPage(),
            '/settings': (context) => SettingsPage(),
          },

        );
      },
    );
  }
}
