import 'dart:io';

import 'eCommerce.dart';
import 'product.dart';

var app = eCommerceApp();

void main() {
  print("Welcome to the ecommerce app");
  print("What would you like to do?");
  print("1. Add a product");
  print("2. View all products");
  print("3. View a product");
  print("4. Edit a product");
  print("5. Delete a product");
  print("6. Exit");
  var option = stdin.readLineSync();

  while (option != "6") {
    switch (option) {
      case "1":
        addProduct();
        break;
      case "2":
        app.viewAllProducts();
        break;
      case "3":
        viewProduct();
        break;
      case "4":
        editProduct();
        break;
      case '5':
        deleteProduct();
        break;
      case '6':
        print("Bye");
        break;
      default:
        print("Invalid option");
        break;
    }
    print("What would you like to do?");
    print("1. Add a product");
    print("2. View all products");
    print("3. View a product");
    print("4. Edit a product");
    print("5. Delete a product");
    print("6. Exit");
    option = stdin.readLineSync();
  }
}

void addProduct() {
  print("Print Enter to continue");
  var enter = "";
  while (enter != "exit") {
    stdout.write("Enter the name of the product: ");
    var name = stdin.readLineSync();
    stdout.write("Enter the description of the product: ");
    var description = stdin.readLineSync();
    stdout.write("Enter the price of the product:");
    var priceInput = stdin.readLineSync();
    var price = priceInput != null ? int.parse(priceInput) : 0;
    if (name != "" && description != "" && price != 0) {
      var product = Product(
          name: name ?? "", description: description ?? "", price: price);
      app.addProduct(product);
      print("Product added successfully");
      print("_________________________");
      print("Print Enter to continue or exit to stop");
    } else {
      print("Invalid input");
    }
    enter = stdin.readLineSync()?.toLowerCase() ?? "";
  }
}

void viewProduct() {
  stdout.write("Enter the name of the product you want to view:");
  var name = stdin.readLineSync();
  if (name != "") {
    app.viewProduct(name ?? "");
  } else {
    print("Invalid input");
  }
}

void editProduct() {
  stdout.write("Enter the name of the product you want to edit: ");
  var name = stdin.readLineSync();
  if (name != "") {
    stdout.write("Enter the new name of the product: ");
    var newName = stdin.readLineSync() ?? name;

    stdout.write("Enter the new description of the product: ");
    var newDescription = stdin.readLineSync();

    stdout.write("Enter the new price of the product: ");
    var newPriceInput = stdin.readLineSync();
    var newPrice = newPriceInput != "" ? int.parse(newPriceInput ?? "") : 0;

    if (newName != "" && newDescription != "" && newPrice != 0) {
      var newProduct = Product(
          name: newName ?? "",
          description: newDescription ?? "",
          price: newPrice);

      app.editProduct(newProduct);
    }
  }
}

void deleteProduct() {
  stdout.write("Enter the name of the product you want to delete: ");
  var name = stdin.readLineSync();
  if (name != "") {
    app.deleteProduct(name ?? "");
    print("Product deleted successfully");
  } else {
    print("Invalid input");
  }
}
