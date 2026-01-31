class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductAdded extends ProductState {}

class AddItemError extends ProductState {
  final String message;
  AddItemError(this.message);
}

