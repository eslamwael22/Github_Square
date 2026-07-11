import '../models/github_repo_model.dart';

abstract class GithubRepository {
  Future<List<GithubRepoModel>> getRepos({required int page});

  List<GithubRepoModel> getCachedRepos();
  Future<void> clearCache();
}
