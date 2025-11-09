import 'package:equatable/equatable.dart';
import 'package:service_shop/app/core/models/attribute/attribute.dart';
import 'package:service_shop/app/core/models/data_tree.dart';
import 'package:service_shop/app/core/models/products/product.dart';

class ProductDetailState extends Equatable {
  final DataTree originalTree;
  final List<Attribute> tree;
  final Product currentProduct;


  const ProductDetailState({
    required this.originalTree,
    required this.tree,
    required this.currentProduct,


  });

  factory ProductDetailState.initial() {
    return ProductDetailState(
      originalTree: DataTree.empty(),
      tree: [],
      currentProduct: Product.empty(),

    );
  }

  ProductDetailState copyWith({
    DataTree? originalTree,
    List<Attribute>? tree,
    Product? currentProduct,

  }) {
    return ProductDetailState(
      originalTree: originalTree ?? this.originalTree,
      tree: tree ?? this.tree,
      currentProduct: currentProduct ?? this.currentProduct,

    );
  }

  @override
  List<Object?> get props => [
    originalTree,
    tree,
    currentProduct,

  ];
}
