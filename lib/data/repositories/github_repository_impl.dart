import 'package:dio/dio.dart';

import '../datasource/local/github_local_datasource.dart';
import '../datasource/remote/github_remote_datasource.dart';
import '../models/github_repo_model.dart';
import 'github_repository.dart';

class GithubRepositoryImpl implements GithubRepository {
  final GithubRemoteDataSource remoteDataSource;
  final GithubLocalDataSource localDataSource;

  GithubRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<GithubRepoModel>> getRepos({required int page}) async {
    try {
      final repos = await remoteDataSource.getRepos(page: page);

      if (page == 1) {
        await localDataSource.saveFirstPage(repos);
      } else {
        await localDataSource.addRepos(repos);
      }

      return repos;
    } on DioException {
      if (page == 1) {
        return localDataSource.getCachedRepos();
      }

      rethrow;
    }
  }

  @override
  List<GithubRepoModel> getCachedRepos() {
    return localDataSource.getCachedRepos();
  }

  @override
  Future<void> clearCache() async {
    await localDataSource.clearCache();
  }
}
