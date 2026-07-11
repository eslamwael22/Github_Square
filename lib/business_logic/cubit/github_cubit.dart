import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'github_state.dart';

class GithubCubit extends Cubit<GithubState> {
  GithubCubit() : super(GithubInitial());
}
