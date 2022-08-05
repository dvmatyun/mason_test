import 'package:{{name.snakeCase()}}/core/locator/locator_registrant.dart';

class CoreLocatorRegistrant implements LocatorRegistrant {
  @override
  Future register() async {
    //locator.registerLazySingleton<PackageInfoDataSource>(() => DefaultPackageInfoDataSource());
    //locator.registerLazySingleton<CacheService>(() => HiveCacheService(packageInfoDataSource: locator.get()));
    //locator.registerLazySingleton<Logger>(() => LoggerFactory.getLogger(locator.get<AppConfiguration>().environment));
    //locator.registerLazySingleton<AnalyticsClient>(() => FirebaseAnalyticsClient());
    //locator.registerLazySingleton<NetworkInfo>(
    //    () => NetworkInfoAlwaysConnectedImpl()); //!NetworkInfoImpl(InternetConnectionChecker()));
    //locator.registerLazySingleton<CityaApiClient>(
    //    () => CityaApiClient(appConfigurations: locator.get())..configureUnauthorizedApiClient());
    //locator.registerLazySingleton<MapboxClient>(() => MapboxClient()..configureMapboxClient());
    //locator.registerLazySingleton<GetFirebaseToken>(() => GetFirebaseToken());
    //locator.registerLazySingleton<DevicePermissions>(() => DevicePermissionsImpl());
    //locator.registerLazySingleton<LocationDataSource>(() => LocationDataSourceImpl());
    //locator.registerLazySingleton(() => GetCurrentLocale());
    //locator.registerSingleton<RemoteConfigsRepository>(FirebaseRemoteConfigRepository());
    //locator.registerLazySingleton(() => GetDisclaimerMessage(remoteConfigsRepository: locator.get()));
    //locator.registerLazySingleton<PopupManager>(() => PopupManagerImpl());
    //locator.registerLazySingleton(() => SoundPlayer());
  }
}
