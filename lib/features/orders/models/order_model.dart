import '../../food/models/product_model.dart';

class OrderItemModel {
  final ProductModel product;
  final int quantity;

  OrderItemModel({
    required this.product,
    required this.quantity,
  });

  double get totalPrice => product.price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'productId': product.id,
      'productName': product.name,
      'price': product.price,
      'quantity': quantity,
      'totalPrice': totalPrice,
    };
  }
}

class OrderModel {
  String? id;
  final List<OrderItemModel> items;
  final String deliveryAddress;
  final double totalAmount;
  final DateTime createdAt;
  final String status; // pending, confirmed, delivered, cancelled
  final String customerUserId;

  OrderModel({
    this.id,
    required this.items,
    required this.deliveryAddress,
    required this.totalAmount,
    required this.createdAt,
    this.status = 'pending',
    required this.customerUserId,
  });

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'deliveryAddress': deliveryAddress,
      'totalAmount': totalAmount,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
      'customerUserId': customerUserId,
    };
  }

  factory OrderModel.fromJson(String id, Map<String, dynamic> json) {
    return OrderModel(
      id: id,
      items: [],
      deliveryAddress: json['deliveryAddress'] ?? '',
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      status: json['status'] ?? 'pending',
      customerUserId: json['customerUserId'] ?? '',
    );
  }
}
