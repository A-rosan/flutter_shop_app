// To parse this JSON data, do
//
//     final getFavModel = getFavModelFromMap(jsonString);

import 'dart:convert';

GetFavModel getFavModelFromMap(String str) => GetFavModel.fromMap(json.decode(str));

String getFavModelToMap(GetFavModel data) => json.encode(data.toMap());

class GetFavModel {
    bool ?status;
    dynamic message;
    Data ?data;

    GetFavModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetFavModel.fromMap(Map<String, dynamic> json) => GetFavModel(
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
    int ?currentPage;
    List<Datum> ?data;
    String ?firstPageUrl;
    int ?from;
    int ?lastPage;
    String ?lastPageUrl;
    dynamic nextPageUrl;
    String ?path;
    int ?perPage;
    dynamic prevPageUrl;
    int ?to;
    int ?total;

    Data({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toMap() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class Datum {
    int ?id;
    Product ?product;

    Datum({
        this.id,
        this.product,
    });

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
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
    String ?name;
    String ?description;

    Product({
        this.id,
        this.price,
        this.oldPrice,
        this.discount,
        this.image,
        this.name,
        this.description,
    });

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        price: json["price"],
        oldPrice: json["old_price"],
        discount: json["discount"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "price": price,
        "old_price": oldPrice,
        "discount": discount,
        "image": image,
        "name": name,
        "description": description,
    };
}
