import 'api_service.dart';
import '../constants/api_constants.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  late final ApiService apiService;

  void initialize() {
    apiService = ApiService(
      baseUrl: ApiConstants.baseUrl,
    );
  }

  void dispose() {
    apiService.dispose();
  }
}
