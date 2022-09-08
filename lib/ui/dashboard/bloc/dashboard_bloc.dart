import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manektech_prac/api_services/api_service.dart';
import 'package:manektech_prac/model/product_response_model.dart';
import 'package:manektech_prac/ui/dashboard/repository/dashboard_repository.dart';

import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository repository;
  int page = 1;
  bool isFetching = false;

  DashboardBloc(
    this.repository,
  ) : super(DashboardInitialState()) {
    on<FetchProductEvent>((event, emit) async {
      emit(DashboardLoadingState());
      try {
        final value = await repository.getProduct(page: page);
        if (value != null) {
          ProductResponse response = ProductResponse.fromJson(value);
          if (response.status == ApiService.successCode) {
            List<ProductData> productList = response.productList ?? [];
            if (productList.isNotEmpty) {
              emit(DashboardSuccessState(productList));

              page++;
            } else {
              emit(DashboardErrorState(response.message.toString()));
            }
          }
        }
      } catch (e) {
        emit(DashboardErrorState(e.toString()));
      }
    });
  }
}
