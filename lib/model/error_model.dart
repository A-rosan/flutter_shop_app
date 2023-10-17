// To parse this JSON data, do
//
//     final errorModel = errorModelFromMap(jsonString);

import 'dart:convert';

ErrorModel errorModelFromMap(String str) => ErrorModel.fromMap(json.decode(str));

String errorModelToMap(ErrorModel data) => json.encode(data.toMap());

class ErrorModel {
    bool ?status;
    String ?message;
    dynamic data;

    ErrorModel({
        this.status,
        this.message,
        this.data,
    });

    factory ErrorModel.fromMap(Map<String, dynamic> json) => ErrorModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data,
    };
}
