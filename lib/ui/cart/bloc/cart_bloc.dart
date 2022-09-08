import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manektech_prac/app_utils/app_string.dart';
import 'package:manektech_prac/database/database_helper.dart';
import 'package:manektech_prac/database/model/cart_product_info.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState()) {
    on<FetchCartEvent>((event, emit) async {
      List<CartProductInfo> value;
      emit(CartLoadingState());
      try {
        value = await DatabaseHelper.getCartProductList();
        emit(CartSuccessState(value));
      } catch (e) {
        emit(CartErrorState(someThingWentWrong));
      }
    });
  }
}
