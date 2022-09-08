import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manektech_prac/app_utils/app_color.dart';
import 'package:manektech_prac/app_utils/app_string.dart';
import 'package:manektech_prac/app_utils/dimens.dart';
import 'package:manektech_prac/common_widget/cart_list_view.dart';
import 'package:manektech_prac/database/model/cart_product_info.dart';
import 'package:manektech_prac/ui/cart/bloc/cart_bloc.dart';
import 'package:manektech_prac/ui/cart/bloc/cart_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartProductInfo>? list = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            cartTitle,
            style: TextStyle(color: colorWhite, fontSize: Dimens.textSize_16),
          ),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        body: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
          builder: (context, state) {
            if (state is CartLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartSuccessState) {
              return Column(
                children: [
                  Expanded(child: CartListView(state.productList!)),
                  Container(
                    color: primaryColor,
                    height: Dimens.margin50,
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.margin10, vertical: Dimens.margin0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('$totalItem: ${state.productList!.length}',
                            style: const TextStyle(
                                color: colorWhite,
                                fontSize: Dimens.textSize_14)),
                        Text('$grandTotal:${getCartTotal(state.productList!)}',
                            style: const TextStyle(
                                color: colorWhite,
                                fontSize: Dimens.textSize_14)),
                      ],
                    ),
                  )
                ],
              );
            } else if (state is CartErrorState) {
              return Text(
                state.errorMessage,
              );
            } else {
              return Container(
                color: Colors.blue,
              );
            }
          },
        ),
      ),
    );
  }

  getCartTotal(List<CartProductInfo> productList) {
    var total = 0.0;
    for (var cartProduct in productList) {
      var amount = (cartProduct.price! * cartProduct.quantity!);
      total += amount;
    }

    return total;
  }
}
