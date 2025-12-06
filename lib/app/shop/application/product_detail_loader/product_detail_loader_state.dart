import 'package:equatable/equatable.dart';
import 'package:service_shop/app/core/models/data_tree.dart';
import 'package:service_shop/core/enum/state_type.dart';

/// [status] - current state of the product detail loading process
/// [error] - error message if any error occurred during loading
/// [dataTree] - hierarchical data structure containing product details and attributes
class ProductDetailLoaderState extends Equatable {
  final StateType status;
  final String? error;
  final DataTree dataTree;

  const ProductDetailLoaderState({
    required this.dataTree,
    this.status = StateType.initial,
    this.error,
  });

  factory ProductDetailLoaderState.initial() {
    return ProductDetailLoaderState(dataTree: DataTree.empty());
  }

  ProductDetailLoaderState copyWith({
    StateType? status,
    String? error,
    DataTree? dataTree,
  }) {
    return ProductDetailLoaderState(
      status: status ?? this.status,
      error: error ?? this.error,
      dataTree: dataTree ?? this.dataTree,
    );
  }

  @override
  List<Object?> get props => [status, error, dataTree];
}
