import 'package:flutter/material.dart';
import 'package:manektech_prac/app_utils/app_color.dart';
import 'package:manektech_prac/app_utils/app_string.dart';
import 'package:manektech_prac/app_utils/dimens.dart';
import 'package:manektech_prac/common_method/common_method.dart';
import 'package:manektech_prac/database/database_helper.dart';
import 'package:manektech_prac/model/product_response_model.dart';

class ProductGridView extends StatelessWidget {
  final ProductData productData;

  const ProductGridView(this.productData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.margin2),
      child: Card(
        semanticContainer: true,
        elevation: 10,
        child: Column(children: [
          SizedBox(
            width: Dimens.margin100,
            height: Dimens.margin100,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(Dimens.margin5),
                  topRight: Radius.circular(Dimens.margin5)),
              child:getImage(productData.featuredImage.toString())/* FadeInImage.assetNetwork(
                fit: BoxFit.fill,
                placeholder: 'assets/no_image.png',
                imageErrorBuilder: (context, url, error) => Image.asset(
                  'assets/no_image.png',
                  fit: BoxFit.fill,
                ),
                image: productData.featuredImage.toString(),
              ),*/
            ),
          ),
          Expanded(
            child: Container(
                margin: const EdgeInsets.only(top: Dimens.margin15),
                decoration: const BoxDecoration(color: Colors.blueAccent),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(Dimens.margin4),
                          child: Text(
                            "${productData.title}",
                            maxLines: 2,
                            softWrap: true,
                            style: const TextStyle(color: colorWhite),
                          ),
                        )),
                    IconButton(
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: colorWhite,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:  Text(addItem)));
                        DatabaseHelper.addToCart(productData, 1);
                      },
                    )
                  ],
                )),
          )
        ]),
      ),
    );
  }


}
