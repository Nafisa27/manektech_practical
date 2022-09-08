class ProductResponse {
  int? status;
  String? message;
  int? totalRecord;
  int? totalPage;
  List<ProductData>? productList;

  ProductResponse({
    this.status,
    this.message,
    this.totalRecord,
    this.totalPage,
    this.productList,
  });

  ProductResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    totalRecord = json['totalRecord'];
    totalPage = json['totalPage'];
    if (json['data'] != null) {
      productList = [];
      json['data'].forEach((v) {
        productList?.add(ProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['totalRecord'] = totalRecord;
    map['totalPage'] = totalPage;
    if (productList != null) {
      map['data'] = productList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ProductData {
  int? id;
  String? slug;
  String? title;
  String? description;
  int? price;
  String? featuredImage;
  String? status;
  String? createdAt;

  ProductData(
      {this.id,
      this.slug,
      this.title,
      this.description,
      this.price,
      this.featuredImage,
      this.status,
      this.createdAt});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    featuredImage = json['featured_image'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['featured_image'] = featuredImage;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}
