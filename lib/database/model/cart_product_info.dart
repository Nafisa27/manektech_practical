import 'package:hive/hive.dart';

part 'cart_product_info.g.dart';

@HiveType(typeId: 1)
class CartProductInfo {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  int? price;
  @HiveField(4)
  String? featuredImage;
  @HiveField(5)
  int? quantity;

  CartProductInfo({
    this.id,
    this.title,
    this.description,
    this.price,
    this.featuredImage,
    this.quantity,
  });

  CartProductInfo.fromJson(dynamic json) {
    id = json['id'];

    title = json['title'];
    description = json['description'];
    price = json['price'];
    featuredImage = json['featured_image'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['price'] = price;
    map['featured_image'] = featuredImage;
    map['quantity'] = quantity;
    return map;
  }
}
