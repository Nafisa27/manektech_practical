import 'package:manektech_prac/api_services/api_service.dart';

class DashboardRepository {
  static final DashboardRepository repository = DashboardRepository._();
  static const int _perPage = 5;

  DashboardRepository._();

  factory DashboardRepository() {
    return repository;
  }

  Future<dynamic> getProduct({
    required int page,
  }) async {
    try {
      var params = <String, String>{
        'page': page.toString(),
        'perPage': _perPage.toString()
      };
      return await ApiService.callPostApi(
          ApiService.productList, params, () {});
    } catch (e) {
      return e.toString();
    }
  }
}
