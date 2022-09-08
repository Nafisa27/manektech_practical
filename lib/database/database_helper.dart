import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:manektech_prac/database/model/cart_product_info.dart';
import 'package:manektech_prac/model/product_response_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static Directory? directory;
  static late Context context;

  static Future<Directory?> init() async {
    Hive.registerAdapter(CartProductInfoAdapter());
    if (!kIsWeb) {
      directory = await getApplicationDocumentsDirectory();
      Hive.init(directory!.path);
      return directory;
    }
    return null;
  }

  static void addToCart(ProductData info, int qty) async {
    getCartProductInfo(info.id!).then((value) {
      if (value.isEmpty) {
        if (kDebugMode) {
          print("init_addToCart");
        }
        addNewCart(info, qty);
        if (kDebugMode) {
          print("AddToCart_______");
        }
      } else {
        addQuantity(value[0]);
      }
    });
  }

  /* static void addQuantitytest(CartProductInfo cartProduct) async {
    var cartProductInfo = CartProductInfo();
    cartProductInfo = cartProduct;
    int q = cartProductInfo.quantity! + 1;
    cartProductInfo.quantity = q;
    // cartProductInfo.save();
  }*/

  static Future<List<CartProductInfo>> getCartProductList() async {
    var box = await Hive.openBox("CartProductInfo");
    var list = box.values.cast<CartProductInfo>().toList();
    return list.toList();
  }

  static void addQuantity(CartProductInfo cartProduct) async {
    var box = await Hive.openBox("CartProductInfo");
    cartProduct.quantity = cartProduct.quantity! + 1;
    dynamic desiredKey;
    final Map deliveriesMap = box.toMap();
    deliveriesMap.forEach((key, value) {
      if (value.id == cartProduct.id) {
        desiredKey = key;
        box.put(desiredKey, cartProduct);
      }
    });
  }

  static Future<List<CartProductInfo>> getCartProductInfo(int productId) async {
    var box = await Hive.openBox("CartProductInfo");
    var list = box.values
        .cast<CartProductInfo>()
        .where((element) => element.id == productId)
        .toList();
    return list.toList();
  }

  static void addNewCart(ProductData info, int qty) async {
    var cartProductInfoBox = await Hive.openBox("CartProductInfo");
    var cartInfo = CartProductInfo();
    cartInfo.id = info.id;
    cartInfo.title = info.title;
    cartInfo.quantity = qty;
    cartInfo.price = info.price;
    cartInfo.featuredImage = info.featuredImage;
    cartProductInfoBox.add(cartInfo);
  }
}
