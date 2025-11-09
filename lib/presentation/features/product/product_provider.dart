import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import '../../../data/models/product_model.dart';

class ProductProvider extends StateNotifier<List<ProductModel>> {
  final Box<ProductModel> box;

  ProductProvider(super.state, this.box);

  // add or update a proudct
  Future<void> addOrUpdateProduct(ProductModel product) async {
    await box.put(product.id, product);
    state = box.values.toList();
  }
  // delete a product by id

  Future<void> deleteProduct(String id) async {
    await box.delete(id);
    state = box.values.toList();
  }

  // update a specific field of a product
  Future<void> updateProductField(
    String id,
    String field,
    dynamic newValue,
  ) async {
    final product = box.get(id);
    if (product != null) {
      // This method is deprecated in favor of addOrUpdateProduct with a copied model.
    }
  }

  // get a product by id
  ProductModel? getProductById(String id) {
    return box.get(id);
  }

  // get all products
  List<ProductModel> get products => state;

  // clear all products
  Future<void> clearProducts() async {
    await box.clear();
    state = [];
  }

  // load products from Hive
  Future<void> loadProducts() async {
    state = box.values.toList();
  }

  Future<List<ProductModel>> getProducts() async {
    state = box.values.toList();
    return state;
  }
}

final productProvider =
    StateNotifierProvider<ProductProvider, List<ProductModel>>(
      (ref) => ProductProvider(
        Hive.box<ProductModel>('productBox').values.toList(),
        Hive.box<ProductModel>('productBox'),
      ),
    );
