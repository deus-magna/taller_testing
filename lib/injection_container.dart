import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:ravn_code_challenge/data/datasources/people_remote_datasource.dart';
import 'package:ravn_code_challenge/data/repositories/people_repository_impl.dart';
import 'package:ravn_code_challenge/domain/repositories/people_repository.dart';
import 'package:ravn_code_challenge/domain/use_cases/get_people_from_server.dart';
import 'package:ravn_code_challenge/presentation/bloc/people_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // Cubits
    ..registerFactory(() => PeopleCubit(getPeopleFromServer: sl()))
    // Use cases
    ..registerLazySingleton(() => GetPeopleFromServer(sl()))
    // Repositories
    ..registerLazySingleton<PeopleRepository>(
        () => PeopleRepositoryImpl(remoteDataSource: sl()))
    // Datasources
    ..registerLazySingleton<PeopleRemoteDataSource>(
        () => PeopleRemoteDataSourceImpl(client: sl()))
    // External dependencies
    ..registerLazySingleton(http.Client.new);
}
