import 'product.dart';

class eCommerceApp {
  List<Product> products = [];

  void addProduct(Product product) {
    products.add(product);
  }

  void viewAllProducts() {
    products.forEach((product) {
      print("Name: ${product.getName}");
      print("Description: ${product.getDescription}");
      print("Price: ${product.getPrice}");
      print("_________________________");
    });
  }

  void viewProduct(String name) {
    products.forEach((product) {
      if (product.getName == name) {
        print("Name: ${product.getName}");
        print("Description: ${product.getDescription}");
        print("Price: ${product.getPrice}");
        print("_________________________");
      }
    });
  }

  void editProduct(Product editProduct) {
    products.forEach((product) {
      if (product.getName == editProduct.getName) {
        product.setName = (editProduct.getName ?? product.getName)!;
        product.setDescription =
            (editProduct.getDescription ?? product.getDescription)!;
        product.setPrice = (editProduct.getPrice ?? product.getPrice)!;
      }
    });
  }

  void deleteProduct(String name) {
    products.removeWhere((product) => product.getName == name);
  }
}
