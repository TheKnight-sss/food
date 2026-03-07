import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/features/orders/models/order_model.dart';

class OrdersService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Save a new order to Firestore
  Future<String?> saveOrder(OrderModel order) async {
    try {
      final docRef = await _firestore.collection('orders').add(order.toJson());
      return docRef.id;
    } catch (e) {
      print('Error saving order: $e');
      return null;
    }
  }

  /// Send notification to admin about new order
  Future<void> notifyAdminNewOrder(OrderModel order) async {
    try {
      // Save notification to Firestore for the admin
      await _firestore.collection('notifications').add({
        'title': 'New Order Received',
        'message': 'New order from delivery address: ${order.deliveryAddress}',
        'orderAmount': order.totalAmount,
        'deliveryAddress': order.deliveryAddress,
        'createdAt': DateTime.now().toIso8601String(),
        'type': 'new_order',
        'orderId': order.id,
        'read': false,
        'recipientType': 'admin',
      });

      // Log the notification
      print('Admin notification saved for order: ${order.id}');
    } catch (e) {
      print('Error notifying admin: $e');
    }
  }

  /// Retrieve orders for a customer
  Future<List<OrderModel>> getCustomerOrders(String customerUserId) async {
    try {
      final snapshot = await _firestore
          .collection('orders')
          .where('customerUserId', isEqualTo: customerUserId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => OrderModel.fromJson(doc.id, doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching customer orders: $e');
      return [];
    }
  }

  /// Get all orders (for admin)
  Future<List<OrderModel>> getAllOrders() async {
    try {
      final snapshot = await _firestore
          .collection('orders')
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => OrderModel.fromJson(doc.id, doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching all orders: $e');
      return [];
    }
  }

  /// Update order status
  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'status': status,
      });
    } catch (e) {
      print('Error updating order status: $e');
    }
  }
}
