import 'package:get_it/get_it.dart';
import 'package:horsehouse/core/network/firestore_caller.dart';
import 'package:horsehouse/features/authentication/data/datasource/authentication_credential_datasource.dart';
import 'package:horsehouse/features/authentication/data/datasource/sign_in_data_source.dart';
import 'package:horsehouse/features/authentication/data/datasource/sign_up_data_source.dart';
import 'package:horsehouse/features/authentication/data/repositories/authentication_credential_repository.dart';
import 'package:horsehouse/features/authentication/data/repositories/sign_in_repository.dart';
import 'package:horsehouse/features/authentication/data/repositories/sign_up_repository.dart';
import 'package:horsehouse/features/authentication/domain/repositories/base_authentication_credential_repository.dart';
import 'package:horsehouse/features/authentication/domain/repositories/base_sign_in_repository.dart';
import 'package:horsehouse/features/authentication/domain/repositories/base_sign_up_repository.dart';
import 'package:horsehouse/features/authentication/domain/usecases/get_auth_credential_use_case.dart';
import 'package:horsehouse/features/authentication/domain/usecases/is_email_unique_use_case.dart';
import 'package:horsehouse/features/authentication/domain/usecases/is_exist_auth_credential_use_case.dart';
import 'package:horsehouse/features/authentication/domain/usecases/log_out_use_case.dart';
import 'package:horsehouse/features/authentication/domain/usecases/save_auth_credential_usecase.dart';
import 'package:horsehouse/features/authentication/domain/usecases/sign_in_use_case.dart';
import 'package:horsehouse/features/authentication/domain/usecases/sign_up_use_case.dart';
import 'package:horsehouse/features/products/data/datasource/products_datasource.dart';
import 'package:horsehouse/features/products/data/repositories/products_repository.dart';
import 'package:horsehouse/features/products/domain/repositories/base_products_repository.dart';
import 'package:horsehouse/features/products/domain/usecases/add_product_to_favorite_use_case.dart';
import 'package:horsehouse/features/products/domain/usecases/get_my_cart_use_case.dart';
import 'package:horsehouse/features/products/domain/usecases/get_my_favorite_product_use_case.dart';
import 'package:horsehouse/features/products/domain/usecases/get_products_use_case.dart';
import 'package:horsehouse/features/products/domain/usecases/remove_from_my_cart_use_case.dart';
import 'package:horsehouse/features/products/domain/usecases/remove_product_from_favorite_use_case.dart';
import 'package:horsehouse/features/products/domain/usecases/update_my_cart_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global/localization/app_localization.dart';
import '../local_data/shared_preferences_services.dart';
import 'date_parser.dart';

final sl = GetIt.instance;

class DependencyInjectionServices {
  init() async {
    /// Shared Preferences  initialize
    await sharedPreferencesInit();


    /// FireStore caller  initialize
    await initializeFireStoreCaller();

    /// Date Parser  initialize
    initializeDateParser();

    /// Localization  initialize
    localizationInit();

    initializeAuthenticationCredential();
    initializeSignUp();
    initializeSignIn();
    initializeProducts();
  }

  sharedPreferencesInit() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton<SharedPreferencesServices>(() => SharedPreferencesServicesImpl(prefs: sl()));
  }



  initializeDateParser() {
    sl.registerLazySingleton<DateParser>(() => DateParser());
  }

  void localizationInit() {
    sl.registerLazySingleton<BaseAppLocalizations>(() => AppLocalizations());
  }

  initializeFireStoreCaller() {
    sl.registerLazySingleton<FireStoreCaller>(() => FireStoreCaller());
  }

  initializeAuthenticationCredential() {
    // Repositories
    sl.registerLazySingleton<BaseAuthenticationCredentialRepository>(() => AuthenticationCredentialRepository(sl()));

    // Use Cases
    sl.registerLazySingleton(() => SaveAuthCredentialUseCase(baseAuthenticationCredentialRepository: sl()));
    sl.registerLazySingleton(() => IsExistAuthCredentialUseCase(baseAuthenticationCredentialRepository: sl()));
    sl.registerLazySingleton(() => GetAuthCredentialUseCase(baseAuthenticationCredentialRepository: sl()));
    sl.registerLazySingleton(() => LogOutUseCase(baseAuthenticationCredentialRepository: sl()));
    // Data Sources
    sl.registerLazySingleton<BaseAuthenticationCredentialDatasource>(() => AuthenticationCredentialDatasource());
  }

  initializeSignUp() {
    // Repositories
    sl.registerLazySingleton<BaseSignUpRepository>(() => SignUpRepository(baseSignUpDatasource: sl()));

    // Use Cases
    sl.registerLazySingleton(() => IsEmailUniqueUseCase(baseSignUpRepository: sl()));
    sl.registerLazySingleton(() => SignUpUseCase(baseSignUpRepository: sl()));

    // Data Sources
    sl.registerLazySingleton<BaseSignUpDatasource>(() => SignUpDatasource());
  }

  initializeSignIn() {
    // Repositories
    sl.registerLazySingleton<BaseSignInRepository>(() => SignInRepository(baseSignInDatasource: sl()));

    // Use Cases
    sl.registerLazySingleton(() => SignInUseCase(baseSignInRepository: sl()));

    // Data Sources
    sl.registerLazySingleton<BaseSignInDatasource>(() => SignInDatasource());
  }

  initializeProducts() {
    // Repositories
    sl.registerLazySingleton<BaseProductsRepository>(() => ProductsRepository(sl()));

    // Use Cases
    sl.registerLazySingleton(() => GetProductsUseCase(baseProductsRepository: sl()));
    sl.registerLazySingleton(() => GetMyFavoriteProductsUseCase(baseProductsRepository: sl()));
    sl.registerLazySingleton(() => RemoveProductFromFavoriteUseCase(baseProductsRepository: sl()));
    sl.registerLazySingleton(() => AddProductToFavoriteUseCase(baseProductsRepository: sl()));
    sl.registerLazySingleton(() => GetMyCartUseCase(baseProductsRepository: sl()));
    sl.registerLazySingleton(() => RemoveFromMyCartUseCase(baseProductsRepository: sl()));
    sl.registerLazySingleton(() => UpdateMyCartUseCase(baseProductsRepository: sl()));

    // Data Sources
    sl.registerLazySingleton<BaseProductsDatasource>(() => ProductsDatasource());
  }
}
