import 'package:ecommerce_task_9/core/network/network_info.dart';
import 'package:ecommerce_task_9/core/util/input_converter.dart';
import 'package:ecommerce_task_9/features/product/data/data_sources/local_data_source.dart';
import 'package:ecommerce_task_9/features/product/data/data_sources/remote_data_source.dart';
import 'package:ecommerce_task_9/features/product/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_task_9/features/product/domain/repositories/product_repositories.dart';
import 'package:ecommerce_task_9/features/product/domain/usecases/add_product.dart';
import 'package:ecommerce_task_9/features/product/domain/usecases/delete_product.dart';
import 'package:ecommerce_task_9/features/product/domain/usecases/get_all_products.dart';
import 'package:ecommerce_task_9/features/product/domain/usecases/get_specifc_product.dart';
import 'package:ecommerce_task_9/features/product/domain/usecases/update_product.dart';
import 'package:ecommerce_task_9/features/product/presentation/bloc/product_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! features
  //bloc
  sl.registerFactory(() => ProductBloc(
      addProductUseCase: sl(),
      getAllProductsUseCase: sl(),
      getSpecificProductUseCase: sl(),
      updateProductUseCase: sl(),
      deleteProductUseCase: sl(),
      inputConverter: sl()));

  //useCases

  sl.registerLazySingleton(() => AddProduct(sl()));
  sl.registerLazySingleton(() => UpdateProduct(sl()));
  sl.registerLazySingleton(() => DeleteProduct(sl()));
  sl.registerLazySingleton(() => GetAllProducts(sl()));
  sl.registerLazySingleton(() => GetSpecificProduct(sl()));

//Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      networkInfo: sl(),
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );

  //Data Sources
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  //! core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      sl(),
    ),
  );

  //!external dependecies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
