import 'package:manektech_prac/model/product_response_model.dart';

abstract class DashboardState {}

class DashboardInitialState extends DashboardState {}

class DashboardLoadingState extends DashboardState {}
class DashboardFetchState extends DashboardState {}

class DashboardSuccessState extends DashboardState {
  final List<ProductData>? productList;

  DashboardSuccessState(this.productList);
}

class DashboardErrorState extends DashboardState {
  final String errorMessage;

  DashboardErrorState(this.errorMessage);
}
