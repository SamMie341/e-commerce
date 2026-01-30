// To parse this JSON data, do
//
//     final bankModel = bankModelFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

List<BankModel> bankModelFromJson(String str) =>
    List<BankModel>.from(json.decode(str).map((x) => BankModel.fromJson(x)));

String bankModelToJson(List<BankModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BankModel {
  final int? id;
  final int? shopId;
  final int? banklogoId;
  final String? accountNo;
  final String? accountName;
  final String? bankqr;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Banklogo? banklogo;

  BankModel({
    this.id,
    this.shopId,
    this.banklogoId,
    this.accountNo,
    this.accountName,
    this.bankqr,
    this.createdAt,
    this.updatedAt,
    this.banklogo,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        id: json["id"] ?? 0,
        shopId: json["shopId"] ?? 0,
        banklogoId: json["banklogoId"] ?? 0,
        accountNo: json["accountNo"] ?? '',
        accountName: json["accountName"] ?? '',
        bankqr: json["bankqr"] ?? '',
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        banklogo: json["banklogo"] == null
            ? null
            : Banklogo.fromJson(json["banklogo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shopId": shopId,
        "banklogoId": banklogoId,
        "accountNo": accountNo,
        "accountName": accountName,
        "bankqr": bankqr,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "banklogo": banklogo?.toJson(),
      };
}

class Banklogo {
  final int id;
  final String? name;
  final String? bankimg;

  Banklogo({
    required this.id,
    this.name,
    this.bankimg,
  });

  factory Banklogo.fromJson(Map<String, dynamic> json) => Banklogo(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        bankimg: json["bankimg"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "bankimg": bankimg,
      };
}

class AddQRModel {
  final int? banklogoId;
  final String accountNo;
  final String accountName;
  final File? bankqr;

  AddQRModel({
    this.banklogoId,
    required this.accountNo,
    required this.accountName,
    this.bankqr,
  });

  factory AddQRModel.fromJson(Map<String, dynamic> json) => AddQRModel(
        banklogoId: json["banklogoId"],
        accountNo: json["accountNo"],
        accountName: json["accountName"],
        bankqr: json["bankqr"],
      );

  Map<String, dynamic> toJson() => {
        "banklogoId": banklogoId,
        "accountNo": accountNo,
        "accountName": accountName,
        "bankqr": bankqr,
      };
}
