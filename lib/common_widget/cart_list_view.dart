import 'package:flutter/material.dart';
import 'package:manektech_prac/app_utils/app_string.dart';
import 'package:manektech_prac/app_utils/dimens.dart';
import 'package:manektech_prac/common_method/common_method.dart';
import 'package:manektech_prac/database/model/cart_product_info.dart';

class CartListView extends StatelessWidget {
  final List<CartProductInfo> productList;

  const CartListView(this.productList, {super.key});

  @override
  Widget build(BuildContext context) {
    return setProductView();
  }

  Widget setProductView() {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Card(
          semanticContainer: true,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.margin8),
            child: Row(children: [
              SizedBox(
                width: 100,
                height: 100,
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(Dimens.margin5),
                        topRight: Radius.circular(Dimens.margin5)),
                    child:
                        getImage(productList[index].featuredImage.toString())),
              ),
              const SizedBox(
                width: Dimens.margin10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${productList[index].title}",
                      style: const TextStyle(
                          fontSize: Dimens.textSize_14,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: Dimens.margin10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text('$price :'),
                        Text('${productList[index].price}'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('$quantity:'),
                        Text('${productList[index].quantity}'),
                      ],
                    )
                  ],
                ),
              ),
            ]),
          ),
        );
      },
      scrollDirection: Axis.vertical,
      itemCount: productList.length,
    );
  }
}
