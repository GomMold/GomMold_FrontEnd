import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../utils/constants.dart';
import 'auth_service.dart';

/// ------------------------------------------------------------
/// COMMON RESPONSE WRAPPER
/// ------------------------------------------------------------
class ResponseWrapper {
  final int statusCode;
  final dynamic data;
  final String? message;

  ResponseWrapper({
    required this.statusCode,
    this.data,
    this.message,
  });

  factory ResponseWrapper.fromHttp(http.Response response) {
    final decoded = jsonDecode(response.body);

    return ResponseWrapper(
      statusCode: response.statusCode,
      data: decoded['data'],
      message: decoded['message'],
    );
  }
}

class ApiService {
  final AuthService _auth = AuthService();

  /// ------------------------------------------------------------
  /// HEADERS
  /// ------------------------------------------------------------
  Future<Map<String, String>> _headers({bool auth = false}) async {
    final headers = {"Content-Type": "application/json"};

    if (auth) {
      final token = await _auth.getToken();
      if (token != null && token.isNotEmpty) {
        headers["Authorization"] = "Bearer $token";
      }
    }
    return headers;
  }

  /// ------------------------------------------------------------
  /// LOGIN
  /// ------------------------------------------------------------
  Future<ResponseWrapper> login(String email, String password) async {
    final url = Uri.parse(Constants.baseUrl + Constants.loginEndpoint);

    try {
      final response = await http.post(
        url,
        headers: await _headers(),
        body: jsonEncode({"email": email, "password": password}),
      );

      return ResponseWrapper.fromHttp(response);
    } catch (e) {
      return ResponseWrapper(statusCode: 500, message: e.toString());
    }
  }

  /// ------------------------------------------------------------
  /// SIGNUP
  /// ------------------------------------------------------------
  Future<ResponseWrapper> signup(
      String email, String password, String username) async {
    final url = Uri.parse(Constants.baseUrl + Constants.signupEndpoint);

    try {
      final response = await http.post(
        url,
        headers: await _headers(),
        body: jsonEncode({
          "email": email,
          "password": password,
          "username": username,
        }),
      );

      return ResponseWrapper.fromHttp(response);
    } catch (e) {
      return ResponseWrapper(statusCode: 500, message: e.toString());
    }
  }

  /// ------------------------------------------------------------
  /// MOLD DETECTION
  /// ------------------------------------------------------------
  Future<ResponseWrapper> detectMold(File imageFile, String analysisName) async {
    final url = Uri.parse(Constants.baseUrl + Constants.detectEndpoint);
    final token = await _auth.getToken();

    try {
      final request = http.MultipartRequest("POST", url);

      if (token != null && token.isNotEmpty) {
        request.headers["Authorization"] = "Bearer $token";
      }

      request.fields["analysis_name"] = analysisName;

      // determine MIME
      final ext = imageFile.path.split('.').last.toLowerCase();
      final mime = _mime(ext).split('/');
      final mediaType = MediaType(mime[0], mime[1]);

      request.files.add(await http.MultipartFile.fromPath(
        "image",
        imageFile.path,
        contentType: mediaType,
      ));

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      return ResponseWrapper.fromHttp(response);
    } catch (e) {
      return ResponseWrapper(statusCode: 500, message: e.toString());
    }
  }
  // ------------------------------------------------------------
  // GET HISTORY (FIXED)
  // ------------------------------------------------------------
  Future<ResponseWrapper> getHistory() async {
  //final url = Uri.parse("${Constants.baseUrl}/api/history/");
  final url = Uri.parse(Constants.baseUrl + Constants.historyEndpoint);

  try {
    final response = await http.get(
      url,
      headers: await _headers(auth: true),
    );

    return ResponseWrapper.fromHttp(response);
  } catch (e) {
    return ResponseWrapper(statusCode: 500, message: e.toString());
  }
}

  /// ------------------------------------------------------------
  /// UPDATE ANALYSIS TITLE (FIXED)
  /// ------------------------------------------------------------
  Future<ResponseWrapper> updateAnalysisTitle(
      String docId, String newTitle) async {
    //final url = Uri.parse("${Constants.baseUrl}/api/history/$docId");
    final url = Uri.parse("${Constants.baseUrl}${Constants.historyBase}/$docId");

    try {
      final response = await http.put(
        url,
        headers: await _headers(auth: true),
        body: jsonEncode({"analysis_name": newTitle}),
      );

      return ResponseWrapper.fromHttp(response);
    } catch (e) {
      return ResponseWrapper(statusCode: 500, message: e.toString());
    }
  }

  /// ------------------------------------------------------------
  /// GET PROFILE
  /// ------------------------------------------------------------
  Future<ResponseWrapper> getProfile() async {
    final url = Uri.parse(Constants.baseUrl + Constants.userProfileEndpoint);

    try {
      final response = await http.get(
        url,
        headers: await _headers(auth: true),
      );

      return ResponseWrapper.fromHttp(response);
    } catch (e) {
      return ResponseWrapper(statusCode: 500, message: e.toString());
    }
  }

  /// ------------------------------------------------------------
  /// UPDATE PROFILE
  /// ------------------------------------------------------------
  Future<ResponseWrapper> updateProfile(
      {String? username, String? password}) async {
    final url = Uri.parse(Constants.baseUrl + Constants.userUpdateEndpoint);

    final data = {};
    if (username != null) data["username"] = username;
    if (password != null) data["password"] = password;

    try {
      final response = await http.patch(
        url,
        headers: await _headers(auth: true),
        body: jsonEncode(data),
      );

      return ResponseWrapper.fromHttp(response);
    } catch (e) {
      return ResponseWrapper(statusCode: 500, message: e.toString());
    }
  }

  /// ------------------------------------------------------------
  /// CHATBOT START
  /// ------------------------------------------------------------
  Future<ResponseWrapper> chatbotStart() async {
    final url = Uri.parse(Constants.baseUrl + Constants.chatbotStartEndpoint);

    try {
      final response = await http.get(
        url,
        headers: await _headers(),
      );

      return ResponseWrapper.fromHttp(response);
    } catch (e) {
      return ResponseWrapper(statusCode: 500, message: e.toString());
    }
  }

  /// ------------------------------------------------------------
  /// CHATBOT QUERY
  /// ------------------------------------------------------------
  Future<ResponseWrapper> chatbotQuery(String question) async {
    final url = Uri.parse(Constants.baseUrl + Constants.chatbotQueryEndpoint);

    try {
      final response = await http.post(
        url,
        headers: await _headers(auth: true),
        body: jsonEncode({"question": question}),
      );

      return ResponseWrapper.fromHttp(response);
    } catch (e) {
      return ResponseWrapper(statusCode: 500, message: e.toString());
    }
  }

  /// ------------------------------------------------------------
  /// MIME TYPE HELPER
  /// ------------------------------------------------------------
  String _mime(String ext) {
    switch (ext) {
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'webp':
        return 'image/webp';
      default:
        return 'application/octet-stream';
    }
  }
}
