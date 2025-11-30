import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Screens
import 'src/screens/initial_page.dart';
import 'src/screens/login_page.dart';
import 'src/screens/sign_up_page.dart';
import 'src/screens/homepage_time.dart';
//import 'src/screens/identify_page.dart';
import 'src/screens/image_page.dart';
import 'src/screens/chatbot_page.dart';
import 'src/screens/settings_page.dart';

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
    return MaterialApp(
      title: 'GomMold',
      debugShowCheckedModeBanner: false,

      // Starting page
      initialRoute: '/initial',

      routes: {
        '/initial': (context) => const InitialPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const HomepageTime(),
        //'/identify': (context) => const IdentifyPage(),
        '/image': (context) => const ImagePage(),
        '/chatbot': (context) => const ChatbotInterfacePage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
