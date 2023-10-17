// To parse this JSON data, do
//
//     final favoritModel = favoritModelFromMap(jsonString);

import 'dart:convert';

FavoritModel favoritModelFromMap(String str) => FavoritModel.fromMap(json.decode(str));

String favoritModelToMap(FavoritModel data) => json.encode(data.toMap());

class FavoritModel {
    bool ?status;
    String ?message;
    Data ?data;

    FavoritModel({
        this.status,
        this.message,
        this.data,
    });
    //store data 
    factory FavoritModel.fromMap(Map<String, dynamic> json) => FavoritModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data!.toMap(),
    };
}

class Data {
    int ?id;
    Product ?product;

    Data({
        this.id,
        this.product,
    });

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        product: Product.fromMap(json["product"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "product": product!.toMap(),
    };
}

class Product {
    int ?id;
    int ?price;
    int ?oldPrice;
    int ?discount;
    String ?image;

    Product({
        this.id,
        this.price,
        this.oldPrice,
        this.discount,
        this.image,
    });

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        price: json["price"],
        oldPrice: json["old_price"],
        discount: json["discount"],
        image: json["image"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "price": price,
        "old_price": oldPrice,
        "discount": discount,
        "image": image,
    };
}
