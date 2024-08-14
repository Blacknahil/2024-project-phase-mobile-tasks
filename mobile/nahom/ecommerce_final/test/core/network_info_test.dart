import 'package:ecommerce_task_9/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../product/helper/test_helper.mocks.dart';

void main() {
  late MockInternetConnectionChecker mockInternetConnectionChecker;
  late NetworkInfoImpl networkInfo;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  group(
    "\nisConnected\n",
    () {
      test(
          "\nshould forward call to the internetConnectionChecker.hasConnection\n",
          () async {
        //arrange
        final tHasConnectionFuture = Future.value(true);

        when(mockInternetConnectionChecker.hasConnection).thenAnswer((_) {
          return tHasConnectionFuture;
        });
        //act
        final result = networkInfo.isConnected;
        //assert
        verify(mockInternetConnectionChecker.hasConnection);
        expect(result, tHasConnectionFuture);
      });
    },
  );
}
