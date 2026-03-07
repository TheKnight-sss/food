import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/features/orders/models/order_model.dart';
import 'package:food/services/firebase/orders_service.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  final OrdersService _ordersService = OrdersService();

  /// Place a new order
  Future<void> placeOrder({
    required List<OrderItemModel> items,
    required String deliveryAddress,
    required double totalAmount,
    required String customerUserId,
  }) async {
    emit(OrderLoading());

    try {
      final order = OrderModel(
        items: items,
        deliveryAddress: deliveryAddress,
        totalAmount: totalAmount,
        createdAt: DateTime.now(),
        status: 'pending',
        customerUserId: customerUserId,
      );

      final orderId = await _ordersService.saveOrder(order);

      if (orderId != null) {
        order.id = orderId;
        
        // Notify admin about the new order
        await _ordersService.notifyAdminNewOrder(order);
        
        emit(OrderSuccess(
          message: 'Order placed successfully!',
          order: order,
        ));
      } else {
        emit(OrderFailure('Failed to save order'));
      }
    } catch (e) {
      emit(OrderFailure('Error placing order: ${e.toString()}'));
    }
  }

  /// Fetch customer orders
  Future<void> fetchCustomerOrders(String customerUserId) async {
    emit(OrderLoading());

    try {
      final orders = await _ordersService.getCustomerOrders(customerUserId);
      emit(OrdersLoaded(orders));
    } catch (e) {
      emit(OrderFailure('Error fetching orders: ${e.toString()}'));
    }
  }

  /// Fetch all orders (for admin)
  Future<void> fetchAllOrders() async {
    emit(OrderLoading());

    try {
      final orders = await _ordersService.getAllOrders();
      emit(OrdersLoaded(orders));
    } catch (e) {
      emit(OrderFailure('Error fetching orders: ${e.toString()}'));
    }
  }

  /// Update order status (admin only)
  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      await _ordersService.updateOrderStatus(orderId, newStatus);
      emit(OrderStatusUpdated(orderId: orderId, newStatus: newStatus));
    } catch (e) {
      emit(OrderFailure('Error updating order status: ${e.toString()}'));
    }
  }
}
