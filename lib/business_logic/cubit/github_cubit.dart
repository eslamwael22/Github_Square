import 'package:bloc/bloc.dart';
import '../../data/models/github_repo_model.dart';
import '../../data/repositories/github_repository.dart';
import 'github_state.dart';

class GithubCubit extends Cubit<GithubState> {
  final GithubRepository repository;

  GithubCubit(this.repository) : super(GithubInitial());

  final List<GithubRepoModel> _repos = [];

  List<GithubRepoModel> filteredRepos = [];

  int currentPage = 1;

  bool hasReachedMax = false;

  bool isLoadingMore = false;

  Future<void> getRepos() async {
    emit(GithubLoading());

    try {
      currentPage = 1;
      _repos.clear();

      final repos = await repository.getRepos(page: currentPage);

      _repos.addAll(repos);

      filteredRepos = List.from(_repos);

      hasReachedMax = repos.length < 10;

      emit(GithubLoaded(repos: filteredRepos, hasReachedMax: hasReachedMax));
    } catch (e) {
      emit(GithubError(e.toString()));
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore || hasReachedMax) return;

    isLoadingMore = true;

    try {
      currentPage++;

      final repos = await repository.getRepos(page: currentPage);

      if (repos.isEmpty) {
        hasReachedMax = true;
      } else {
        repos.addAll(repos);

        filteredRepos = List.from(_repos);

        if (repos.length < 10) {
          hasReachedMax = true;
        }
      }

      emit(GithubLoaded(repos: filteredRepos, hasReachedMax: hasReachedMax));
    } finally {
      isLoadingMore = false;
    }
  }

  Future<void> refreshRepos() async {
    await repository.clearCache();

    await getRepos();
  }

  void search(String text) {
    if (text.trim().isEmpty) {
      filteredRepos = List.from(_repos);
    } else {
      filteredRepos = _repos.where((repo) {
        return repo.name.toLowerCase().contains(text.toLowerCase());
      }).toList();
    }

    emit(GithubLoaded(repos: filteredRepos, hasReachedMax: hasReachedMax));
  }
}
