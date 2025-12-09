{{#use_api}}
/// API Constants
class ApiConstants {
  // Base URL
  static const String baseUrl = '{{api_base_url}}';

  // API Key
  static const String apiKey = '{{newsdata_api_key}}';

  // Endpoints
  static const String latestNewsEndpoint = '/latest';

  // Query Parameters
  static const String apiKeyParam = 'apikey';

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Private constructor
  ApiConstants._();
}
{{/use_api}}
