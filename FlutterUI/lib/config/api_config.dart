class ApiConfig {
  // Base URLs
  static const String mockBaseUrl =
      'https://03c2b18f-3c9e-42a1-ab33-ec409c08fdda.mock.pstmn.io';

  // Endpoints
  static const String processImage = '/process-image';

  // Full URLs
  static String get imageProcessingUrl => '$mockBaseUrl$processImage';
}
