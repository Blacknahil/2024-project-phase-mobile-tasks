import 'package:ecommerce_task_9/core/platform/network_info.dart';
import 'package:ecommerce_task_9/features/product/data/data_sources/local_data_source.dart';
import 'package:ecommerce_task_9/features/product/data/data_sources/remote_data_source.dart';
import 'package:ecommerce_task_9/features/product/domain/repositories/product_repositories.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    ProductRepository,
    NetworkInfo,
    LocalDataSource,
    RemoteDataSource,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
