class Constants {
  // Replace with your current ngrok URL (no trailing slash)
  static const String baseUrl = "https://unbuoyant-seriately-ingeborg.ngrok-free.dev";

  // Auth
  static const String loginEndpoint = "/api/auth/login";
  static const String signupEndpoint = "/api/auth/signup";

  // Mold
  static const String detectEndpoint = "/api/mold/detect";
  // history blueprint mounted at /api/history with route /history
  static const String historyEndpoint = "/api/history/history";

  // Chatbot
  static const String chatbotStartEndpoint = "/api/chatbot/start";
  static const String chatbotQueryEndpoint = "/api/chatbot/query";

  // User
  static const String profileEndpoint = "/api/user/profile";
  static const String updateUserEndpoint = "/api/user/update";
}
