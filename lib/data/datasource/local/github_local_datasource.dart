import 'package:hive_flutter/hive_flutter.dart';
import '../../models/github_repo_model.dart';

abstract class GithubLocalDataSource {
  Future<void> cacheRepos(List<GithubRepoModel> repos);

  List<GithubRepoModel> getCachedRepos();

  Future<void> clearCache();
}

class GithubLocalDataSourceImpl implements GithubLocalDataSource {
  final Box<GithubRepoModel> box;

  GithubLocalDataSourceImpl({required this.box});

  @override
  Future<void> cacheRepos(List<GithubRepoModel> repos) async {
    await box.clear();
    await box.addAll(repos);
  }

  @override
  List<GithubRepoModel> getCachedRepos() {
    return box.values.toList();
  }

  @override
  Future<void> clearCache() async {
    await box.clear();
  }
}
