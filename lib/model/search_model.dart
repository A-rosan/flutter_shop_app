// To parse this JSON data, do
//
//     final searchModel = searchModelFromMap(jsonString);

import 'dart:convert';

SearchModel searchModelFromMap(String str) => SearchModel.fromMap(json.decode(str));

String searchModelToMap(SearchModel data) => json.encode(data.toMap());

class SearchModel {
    bool ?status;
    dynamic message;
    Data ?data;

    SearchModel({
        this.status,
        this.message,
        this.data,
    });

    factory SearchModel.fromMap(Map<String, dynamic> json) => SearchModel(
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
    List<DatumSearch> ?data;
    String ?firstPageUrl;
    int ?from;
    int ?lastPage;
    String ?lastPageUrl;
    dynamic nextPageUrl;
    String ?path;
    int ?perPage;
    dynamic prevPageUrl;
    int? to;
    int? total;

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
        data: List<DatumSearch>.from(json["data"].map((x) => DatumSearch.fromMap(x))),
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

class DatumSearch {
    int ?id;
    double ?price;
    String ?image;
    String ?name;
    String ?description;
    List<String> ?images;
    bool ?inFavorites;
    bool ?inCart;

    DatumSearch({
        this.id,
        this.price,
        this.image,
        this.name,
        this.description,
        this.images,
        this.inFavorites,
        this.inCart,
    });

    factory DatumSearch.fromMap(Map<String, dynamic> json) => DatumSearch(
        id: json["id"],
        price: json["price"].toDouble(),
        image: json["image"],
        name: json["name"],
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
        inFavorites: json["in_favorites"],
        inCart: json["in_cart"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "price": price,
        "image": image,
        "name": name,
        "description": description,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "in_favorites": inFavorites,
        "in_cart": inCart,
    };
}
