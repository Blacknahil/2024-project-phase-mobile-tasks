class Urls {
  static const String baseUrl = "3001";
  static const String apiKey = "some key";
  static currentProductById(int id) => '$baseUrl/product?q=$id&appid=$apiKey';
}
