import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../utils/constants.dart';
import 'auth_service.dart';

class ApiService {
  final AuthService _authService = AuthService();

  // LOGIN
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse(Constants.baseUrl + Constants.loginEndpoint);
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      return {
        "statusCode": response.statusCode,
        "body": jsonDecode(response.body)
      };
    } catch (e) {
      return {"statusCode": 500, "body": {"message": "An error occurred: $e"}};
    }
  }

  // SIGNUP (backend expects username)
  Future<Map<String, dynamic>> signup(String email, String password, String username) async {
    final url = Uri.parse(Constants.baseUrl + Constants.signupEndpoint);
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
          "username": username,
        }),
      );

      return {
        "statusCode": response.statusCode,
        "body": jsonDecode(response.body)
      };
    } catch (e) {
      return {"statusCode": 500, "body": {"message": "An error occurred: $e"}};
    }
  }

  // MOLD DETECTION - multipart/form-data with file field named "image"
  Future<Map<String, dynamic>> detectMold(File imageFile) async {
    final url = Uri.parse(Constants.baseUrl + Constants.detectEndpoint);
    final token = await _authService.getToken();

    try {
      final request = http.MultipartRequest('POST', url);
      if (token != null && token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      final mimeType = lookupMimeType(imageFile.path) ?? 'image/jpeg';
      final mimeParts = mimeType.split('/');

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
        contentType: MediaType(mimeParts[0], mimeParts[1]),
      ));

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      return {
        "statusCode": response.statusCode,
        "body": jsonDecode(response.body)
      };
    } catch (e) {
      return {"statusCode": 500, "body": {"message": "An error occurred: $e"}};
    }
  }

  // GET HISTORY (requires Authorization)
  Future<Map<String, dynamic>> getHistory() async {
    final url = Uri.parse(Constants.baseUrl + Constants.historyEndpoint);
    final token = await _authService.getToken();

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          if (token != null && token.isNotEmpty) "Authorization": "Bearer $token"
        },
      );

      return {
        "statusCode": response.statusCode,
        "body": jsonDecode(response.body)
      };
    } catch (e) {
      return {"statusCode": 500, "body": {"message": "An error occurred: $e"}};
    }
  }

  // CHATBOT START (greeting)
  Future<Map<String, dynamic>> chatbotStart() async {
    final url = Uri.parse(Constants.baseUrl + Constants.chatbotStartEndpoint);
    try {
      final response = await http.get(url);
      return {
        "statusCode": response.statusCode,
        "body": jsonDecode(response.body)
      };
    } catch (e) {
      return {"statusCode": 500, "body": {"message": "An error occurred: $e"}};
    }
  }

  // CHATBOT QUERY (backend expects { "question": ... })
  Future<Map<String, dynamic>> chatbotQuery(String question) async {
    final url = Uri.parse(Constants.baseUrl + Constants.chatbotQueryEndpoint);
    final token = await _authService.getToken();

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          if (token != null && token.isNotEmpty) "Authorization": "Bearer $token"
        },
        body: jsonEncode({"question": question}),
      );

      return {
        "statusCode": response.statusCode,
        "body": jsonDecode(response.body)
      };
    } catch (e) {
      return {"statusCode": 500, "body": {"message": "An error occurred: $e"}};
    }
  }
}

// helper: lookupMimeType requires package:mime; but to avoid adding libs here we create a simple function.
// If you want more accurate detection add `mime` package and use lookupMimeType from it.
String? lookupMimeType(String path) {
  final ext = path.split('.').last.toLowerCase();
  switch (ext) {
    case 'png':
      return 'image/png';
    case 'jpg':
    case 'jpeg':
      return 'image/jpeg';
    case 'webp':
      return 'image/webp';
    default:
      return null;
  }
}
