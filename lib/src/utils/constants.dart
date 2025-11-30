class Constants {
  // BASE URL
  static const String baseUrl = "https://gommold-backend-production.up.railway.app";

  // AUTH
  static const String loginEndpoint = "/api/auth/login";
  static const String signupEndpoint = "/api/auth/signup";

  // MOLD DETECTION
  static const String detectEndpoint = "/api/mold/detect";

  // HISTORY
  static const String historyEndpoint = "/api/history";

  // CHATBOT
  static const String chatbotStartEndpoint = "/api/chatbot/start";
  static const String chatbotQueryEndpoint = "/api/chatbot/query";

  // USER PROFILE
  static const String userProfileEndpoint = "/api/user/profile";
  static const String userUpdateEndpoint = "/api/user/update";
}
