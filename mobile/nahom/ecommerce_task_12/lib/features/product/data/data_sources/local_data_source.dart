import '../models/product_model.dart';

abstract class LocalDataSource {
  /// Gets the cached [Product] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<ProductModel> getSpecificProduct(int id);

  /// Gets the cached [Products] which was gotten the last time
  ///the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<ProductModel>> getAllProducts();

  Future<void> cacheAllProducts(List<ProductModel> products);
}
