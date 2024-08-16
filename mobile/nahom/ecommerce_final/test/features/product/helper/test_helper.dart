import 'package:ecommerce_task_9/core/network/network_info.dart';
import 'package:ecommerce_task_9/features/product/data/data_sources/local_data_source.dart';
import 'package:ecommerce_task_9/features/product/data/data_sources/remote_data_source.dart';
import 'package:ecommerce_task_9/features/product/domain/repositories/product_repositories.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks(
  [
    ProductRepository,
    NetworkInfo,
    LocalDataSource,
    RemoteDataSource,
    InternetConnectionChecker,
    SharedPreferences,
    http.MultipartFile,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
