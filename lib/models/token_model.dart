//     final tokenData = tokenDataFromJson(jsonString);

import 'dart:convert';

TokenData tokenDataFromJson(String str) => TokenData.fromJson(json.decode(str));

String tokenDataToJson(TokenData data) => json.encode(data.toJson());

class TokenData {
  TokenData({
    this.success,
    this.data,
  });

  bool? success;
  List<TokenInfo>? data;

  factory TokenData.fromJson(Map<String, dynamic> json) => TokenData(
        success: json["success"],
        data: List<TokenInfo>.from(
            json["data"].map((x) => TokenInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TokenInfo {
  TokenInfo({
    this.symbol,
    this.price,
  });

  String? symbol;
  double? price;

  factory TokenInfo.fromJson(Map<String, dynamic> json) => TokenInfo(
        symbol: json["symbol"],
        price: json["price"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "price": price,
      };
}
