// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

ProductsModel productsModelFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
    ProductsModel({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    int mainCode;
    int code;
    List<Datum> data;
    List<Error> error;

    factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"] == null ? null : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error == null ? null : List<dynamic>.from(error.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.sku,
        this.name,
        this.attributeSetId,
        this.price,
        this.status,
        this.visibility,
        this.typeId,
        this.createdAt,
        this.updatedAt,
        this.weight,
        this.productLinks,
        this.tierPrices,
        this.customAttributes,
    });

    int id;
    String sku;
    String name;
    int attributeSetId;
    double price;
    int status;
    int visibility;
    String typeId;
    DateTime createdAt;
    DateTime updatedAt;
    double weight;
    List<dynamic> productLinks;
    List<dynamic> tierPrices;
    List<CustomAttribute> customAttributes;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        sku: json["sku"] == null ? null : json["sku"],
        name: json["name"] == null ? null : json["name"],
        attributeSetId: json["attribute_set_id"] == null ? null : json["attribute_set_id"],
        price: json["price"] == null ? null : json["price"].toDouble(),
        status: json["status"] == null ? null : json["status"],
        visibility: json["visibility"] == null ? null : json["visibility"],
        typeId: json["type_id"] == null ? null : json["type_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        weight: json["weight"] == null ? null : json["weight"].toDouble(),
        productLinks: json["product_links"] == null ? null : List<dynamic>.from(json["product_links"].map((x) => x)),
        tierPrices: json["tier_prices"] == null ? null : List<dynamic>.from(json["tier_prices"].map((x) => x)),
        customAttributes: json["custom_attributes"] == null ? null : List<CustomAttribute>.from(json["custom_attributes"].map((x) => CustomAttribute.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "sku": sku == null ? null : sku,
        "name": name == null ? null : name,
        "attribute_set_id": attributeSetId == null ? null : attributeSetId,
        "price": price == null ? null : price,
        "status": status == null ? null : status,
        "visibility": visibility == null ? null : visibility,
        "type_id": typeId == null ? null : typeId,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "weight": weight == null ? null : weight,
        "product_links": productLinks == null ? null : List<dynamic>.from(productLinks.map((x) => x)),
        "tier_prices": tierPrices == null ? null : List<dynamic>.from(tierPrices.map((x) => x)),
        "custom_attributes": customAttributes == null ? null : List<dynamic>.from(customAttributes.map((x) => x.toJson())),
    };
}

class CustomAttribute {
    CustomAttribute({
        this.attributeCode,
        this.value,
    });

    String attributeCode;
    String value;

    factory CustomAttribute.fromJson(Map<String, dynamic> json) => CustomAttribute(
        attributeCode: json["attribute_code"] == null ? null : json["attribute_code"],
        value: json["value"] == null ? null : json["value"],
    );

    Map<String, dynamic> toJson() => {
        "attribute_code": attributeCode == null ? null : attributeCode,
        "value": value == null ? null : value,
    };
}

class Error {
    Error({
        this.key,
        this.value,
    });

    String key;
    String value;

    factory Error.fromJson(Map<String, dynamic> json) => Error(
        key: json["key"] == null ? null : json["key"],
        value: json["value"] == null ? null : json["value"],
    );

    Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "value": value == null ? null : value,
    };
}
