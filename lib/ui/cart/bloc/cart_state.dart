import 'package:manektech_prac/database/model/cart_product_info.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}
class CartTotalState extends CartState {
  final String totalItem;

  CartTotalState(this.totalItem);
}

class CartSuccessState extends CartState {
  final List<CartProductInfo>? productList;

  CartSuccessState(this.productList);
}

class CartErrorState extends CartState {
  final String errorMessage;

  CartErrorState(this.errorMessage);
}
