import 'package:ecommerce_task_9/core/platform/network_info.dart';
import 'package:ecommerce_task_9/features/product/data/data_sources/product_local_data_source.dart';
import 'package:ecommerce_task_9/features/product/data/data_sources/product_remote_data_source.dart';
import 'package:ecommerce_task_9/features/product/domain/repositories/product_repositories.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(
  [
    ProductRepository,
    NetworkInfo,
    ProductLocalDataSource,
    ProductRemoteDataSource,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
