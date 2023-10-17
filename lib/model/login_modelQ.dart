// To parse this JSON data, do
//
//     final loginModelQ = loginModelQFromMap(jsonString);

import 'dart:convert';

LoginModel loginModelQFromMap(String str) => LoginModel.fromMap(json.decode(str));

String loginModelQToMap(LoginModel data) => json.encode(data.toMap());

class LoginModel {
    bool ?status;
    String? message;
    Data ?data;

    LoginModel({
        this.status,
        this.message,
        this.data,
    });

    factory LoginModel.fromMap(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data?.toMap(),
    };
}

class Data {
    int ?id;
    String ?name;
    String ?email;
    String? phone;
    String ?image;
    int ?points;
    int ?credit;
    String ?token;

    Data({
        this.id,
        this.name,
        this.email,
        this.phone,
        this.image,
        this.points,
        this.credit,
        this.token,
    });

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        points: json["points"],
        credit: json["credit"],
        token: json["token"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "image": image,
        "points": points,
        "credit": credit,
        "token": token,
    };
}
