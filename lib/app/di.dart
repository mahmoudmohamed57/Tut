import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut/app/app_prefs.dart';
import 'package:tut/data/data_source/local_data_source.dart';
import 'package:tut/data/data_source/remote_data_source.dart';
import 'package:tut/data/network/app_api.dart';
import 'package:tut/data/network/dio_factory.dart';
import 'package:tut/data/network/network_info.dart';
import 'package:tut/data/repository/repository_impl.dart';
import 'package:tut/domain/repository/repository.dart';
import 'package:tut/domain/usecase/details_usecase.dart';
import 'package:tut/domain/usecase/forgot_password_usecase.dart';
import 'package:tut/domain/usecase/home_usecase.dart';
import 'package:tut/domain/usecase/login_usecase.dart';
import 'package:tut/domain/usecase/register_usecase.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  // shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // app  service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));

  // local data source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  // repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
  }
}

initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(instance()),
    );
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory<RegisterUseCase>(
      () => RegisterUseCase(instance()),
    );
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
  }
}

initDetailsModule() {
  if (!GetIt.I.isRegistered<DetailsUseCase>()) {
    instance.registerFactory<DetailsUseCase>(() => DetailsUseCase(instance()));
  }
}
