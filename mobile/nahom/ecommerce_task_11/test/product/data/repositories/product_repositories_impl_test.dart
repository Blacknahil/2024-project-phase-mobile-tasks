import 'package:ecommerce_task_9/features/product/data/repositories/product_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late ProductRepositoryImpl productRepositoryImpl;
  late MockProductRemoteDataSource mockProductRemoteDataSource;
  late MockProductLocalDataSource mockProductLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  setUp(() {
    mockProductRemoteDataSource = MockProductRemoteDataSource();
    mockProductLocalDataSource = MockProductLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    productRepositoryImpl = ProductRepositoryImpl(
      productLocalDataSource: mockProductLocalDataSource,
      productRemoteDataSource: mockProductRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });
}
