import 'package:dio/dio.dart';

import '../../../core/network/api_constants.dart';
import '../../models/github_repo_model.dart';

abstract class GithubRemoteDataSource {
  Future<List<GithubRepoModel>> getRepos({required int page});
}

class GithubRemoteDataSourceImpl implements GithubRemoteDataSource {
  final Dio dio;

  GithubRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<GithubRepoModel>> getRepos({required int page}) async {
    final response = await dio.get(
      ApiConstants.squareRepos,
      queryParameters: {'page': page, 'per_page': 10},
    );

    final List data = response.data;
    return data.map((repo) => GithubRepoModel.fromJson(repo)).toList();
  }
}
