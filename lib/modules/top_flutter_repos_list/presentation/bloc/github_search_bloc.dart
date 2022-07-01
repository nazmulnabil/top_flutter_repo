
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/data/models/flutter_repository_model.dart';
import '../../domain/use_cases/get_top_flutter_repo_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'github_search_event.dart';
part 'github_search_state.dart';






const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class GithubSearchBloc extends Bloc<GithubSearchEvent, GithubSearchState> {

  String keyword='';
  final GetTopFlutterRepos getTopFlutterRepos;
  var shortedList=<FlutterRepositoryModel>[];
  var shortedListfromSession=<FlutterRepositoryModel>[];
  bool isSorted=false;
  var currentList=<FlutterRepositoryModel>[];



  GithubSearchBloc({required this.getTopFlutterRepos})
      : super(SearchStateEmpty()) {
    on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
    on<OnRefreshApi>(_onRefreshApi, transformer: debounce(_duration));
    on<SortedList>(_onSortedList, transformer: debounce(_duration));
  }



  void _onTextChanged(
      TextChanged event,
      Emitter<GithubSearchState> emit,
      ) async {
    final searchTerm = event.text;
    if (kDebugMode) {
      print(searchTerm);
    }

    if (searchTerm.isEmpty) return emit(SearchStateEmpty());

    emit(SearchStateLoading());

    try {

      final results = await getTopFlutterRepos.fetchTopFlutterRepos(term: searchTerm);
      currentList=results;
      if (kDebugMode) {
        print('inside bloc after api calling result/////////////// $results');
      }
      keyword=searchTerm;
      shortedList.clear();
      shortedList=[...results];
      shortedList.sort((a, b) => b.updatedAt.toString().compareTo(a.updatedAt.toString()));

     if (kDebugMode) {
       print('shorted list name>>>>>>>>>>>> ${shortedList.map((e) => e.name)}');
     }

      emit(SearchStateSuccess(results));
    } catch (error) {
      emit(error is SearchStateError
          ? SearchStateError(error.error)
          : const SearchStateError('something went wrong'));
    }
  }

  void _onSortedList(
      SortedList event,
      Emitter<GithubSearchState> emit,
      ) async {
   // emit(SearchStateLoading());
    try {
      emit(SearchStateSuccess(isSorted?shortedList:currentList));
    } catch (error) {
      emit(error is SearchStateError
          ? SearchStateError(error.error)
          : const SearchStateError('something went wrong'));
    }
  }

  void _onRefreshApi(
      OnRefreshApi event,
      Emitter<GithubSearchState> emit,
      ) async {
    final onRefreshTerm =keyword;
    if (kDebugMode) {
      print(onRefreshTerm);
    }

    if (onRefreshTerm.isEmpty) return emit(SearchStateEmpty());

    emit(SearchStateLoading());

    try {

      final results = await getTopFlutterRepos.fetchTopFlutterRepos(term: onRefreshTerm);
      currentList=[...results];
      if (kDebugMode) {
        print('inside bloc after api calling result/////////////// $results');
      }
      keyword=onRefreshTerm;
      shortedList.clear();
      shortedList=[...results];
      shortedList.sort((a, b) => a.updatedAt.toString().compareTo(b.updatedAt.toString()));

      if (kDebugMode) {
        print('shorted list name>>>>>>>>>>>> ${shortedList.map((e) => e.name)}');
      }
      //print('json Tags>>>>>>>>>>>> $sortedListToJson)}');

      emit(SearchStateSuccess(results));
    } catch (error) {
      emit(error is SearchStateError
          ? SearchStateError(error.error)
          : const SearchStateError('something went wrong'));
    }
  }
}