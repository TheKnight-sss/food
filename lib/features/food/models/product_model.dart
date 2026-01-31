import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final String category;

  ProductModel({
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "price": price,
      "description": description,
      "imageUrl": imageUrl,
      "category": category,
      "createdAt": FieldValue.serverTimestamp(),
    };
  }
}
