import 'package:clean_arch/core/platform/network_info.dart';
import 'package:clean_arch/features/data/datasourses/person_local_data_sour5ce.dart';
import 'package:clean_arch/features/data/datasourses/person_remote_data_source.dart';
import 'package:clean_arch/features/data/repository/person_repository_impl.dart';
import 'package:clean_arch/features/domain/usecases/get_all_persons.dart';
import 'package:clean_arch/features/domain/usecases/search_person.dart';
import 'package:clean_arch/features/presentation/bloc/sreach_bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/domain/repository/person.repository.dart';
import 'features/presentation/bloc/person_list_cubit/person_list_cubit.dart';

final sl = GetIt.instance;

Future<void> init()async{
  // Bloc / cubit
  sl.registerFactory(() => PersonListCubit(getAllPersons: sl()));
  sl.registerFactory(() => PersonSearchBloc(searchPerson: sl()));

  // UseCases
  sl.registerLazySingleton(() => GetAllPersons(sl()));
  sl.registerLazySingleton(() => SearchPerson(sl()));

  // Repository
  sl.registerLazySingleton<PersonRepository>(() => PersonRepositoryImpl(
      personRemoteDataSource: sl(),
      personLocalDataSource: sl(),
      networkInfo: sl()));
  sl.registerLazySingleton<PersonRemoteDataSource>(() => PersonRemoteDataSourceImpl(client: http.Client()));
  sl.registerLazySingleton<PersonLocalDataSource>(() => PersonLocalDataSourceImpl(sharedPreferences: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}