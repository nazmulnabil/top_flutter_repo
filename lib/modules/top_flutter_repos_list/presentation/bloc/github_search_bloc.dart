
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/data/models/flutter_repository_model.dart';

import '../../domain/entities/flutter_project.dart';
import '../../domain/use_cases/get_top_flutter_repo_list.dart';
part 'github_search_event.dart';
part 'github_search_state.dart';






const _duration = const Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class GithubSearchBloc extends Bloc<GithubSearchEvent, GithubSearchState> {
  GithubSearchBloc({required this.getTopFlutterRepos})
      : super(SearchStateEmpty()) {
    on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
  }

  final GetTopFlutterRepos getTopFlutterRepos;

  void _onTextChanged(
      TextChanged event,
      Emitter<GithubSearchState> emit,
      ) async {
    final searchTerm = event.text;

    if (searchTerm.isEmpty) return emit(SearchStateEmpty());

    emit(SearchStateLoading());

    try {
      final results = await getTopFlutterRepos.fetchTopFlutterRepos();
      emit(SearchStateSuccess(results));
    } catch (error) {
      emit(error is SearchStateError
          ? SearchStateError(error.error)
          : SearchStateError('something went wrong'));
    }
  }
}