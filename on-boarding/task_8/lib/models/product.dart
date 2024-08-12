class Product {
  int? _id;
  String? _name;
  String? _catagory;
  String? _description;
  int? _price;

  Product(
      {required int id,
      required String name,
      required catagory,
      required String description,
      required int price}) {
    _id = id;
    _name = name;
    _catagory = catagory;
    _description = description;
    _price = price;
  }

  String? get getName => _name;
  int? get getId => _id;
  String? get getDescription => _description;
  int? get getPrice => _price;
  String? get getCatagory => _catagory;

  set setName(String name) {
    _name = name;
  }

  set setDescription(String description) {
    _description = description;
  }

  set setPrice(int price) {
    _price = price;
  }

  set setCatagory(String catagory) {
    _catagory = catagory;
  }
}
