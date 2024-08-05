class Product {
  String? _name;
  String? _description;
  int? _price;

  Product(
      {required String name, required String description, required int price}) {
    this._name = name;
    this._description = description;
    this._price = price;
    print("Product created successfully");
  }

  String? get getName => _name;
  String? get getDescription => _description;
  int? get getPrice => _price;

  set setName(String name) {
    this._name = name;
  }

  set setDescription(String description) {
    this._description = description;
  }

  set setPrice(int price) {
    this._price = price;
  }
}
