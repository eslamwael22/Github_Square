import 'package:get_it/get_it.dart';
import 'package:github_square/core/network/api_helper.dart';
import 'package:github_square/data/datasource/local/github_local_datasource.dart';
import 'package:github_square/data/datasource/remote/github_remote_datasource.dart';
import 'package:github_square/data/models/github_repo_model.dart';
import 'package:github_square/data/models/owner_model.dart';
import 'package:github_square/data/repositories/github_repository.dart';
import 'package:github_square/data/repositories/github_repository_impl.dart';
import 'package:hive_flutter/hive_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  await Hive.initFlutter();

  Hive.registerAdapter(GithubRepoModelAdapter());
  Hive.registerAdapter(OwnerModelAdapter());

  final box = await Hive.openBox<GithubRepoModel>('repos');

  getIt.registerLazySingleton(() => DioHelper.instance.dio);

  getIt.registerLazySingleton(() => box);

  getIt.registerLazySingleton<GithubRemoteDataSource>(
    () => GithubRemoteDataSourceImpl(dio: getIt()),
  );

  getIt.registerLazySingleton<GithubLocalDataSource>(
    () => GithubLocalDataSourceImpl(box: getIt()),
  );

  getIt.registerLazySingleton<GithubRepository>(
    () => GithubRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
    ),
  );
}
