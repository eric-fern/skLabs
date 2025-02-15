class ApiConstants {
  // Replace these with your actual Azure APIM values
  static const String baseUrl = 'YOUR_AZURE_APIM_URL';
  static const String subscriptionKey = 'YOUR_SUBSCRIPTION_KEY';

  // API Endpoints
  static const String imageProcessEndpoint = '/api/process-image';

  // Headers
  static const Map<String, String> defaultHeaders = {
    'Accept': 'application/json',
    'Ocp-Apim-Subscription-Key': subscriptionKey,
    'Content-Type': 'application/json',
  };

  // Multipart request headers
  static const Map<String, String> multipartHeaders = {
    'Accept': 'application/json',
    'Ocp-Apim-Subscription-Key': subscriptionKey,
  };
}
