import 'package:equatable/equatable.dart';
import '../../data/models/github_repo_model.dart';

abstract class GithubState extends Equatable {
  const GithubState();

  @override
  List<Object?> get props => [];
}

class GithubInitial extends GithubState {}

class GithubLoading extends GithubState {}

class GithubLoaded extends GithubState {
  final List<GithubRepoModel> repos;
  final bool hasReachedMax;

  const GithubLoaded({required this.repos, required this.hasReachedMax});

  @override
  List<Object?> get props => [repos, hasReachedMax];
}

class GithubError extends GithubState {
  final String message;
  const GithubError(this.message);

  @override
  List<Object?> get props => [message];
}
