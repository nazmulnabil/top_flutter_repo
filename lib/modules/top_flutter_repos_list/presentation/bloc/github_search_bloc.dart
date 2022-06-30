
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/data/models/flutter_repository_model.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import '../../domain/entities/flutter_project.dart';
import '../../domain/use_cases/get_top_flutter_repo_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    on<SortedList>(_onSortedList, transformer: debounce(_duration));
  }
  String keyword='';
  final GetTopFlutterRepos getTopFlutterRepos;
  var shortedList=<FlutterRepositoryModel>[];
  var shortedListfromSession=<FlutterRepositoryModel>[];
  bool isSorted=false;

  var currentList=<FlutterRepositoryModel>[];


  void _onTextChanged(
      TextChanged event,
      Emitter<GithubSearchState> emit,
      ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final searchTerm = event.text;
    print(searchTerm);

    if (searchTerm.isEmpty) return emit(SearchStateEmpty());

    emit(SearchStateLoading());

    try {

      final results = await getTopFlutterRepos.fetchTopFlutterRepos(term: searchTerm);
      currentList=[...results];
      if (kDebugMode) {
        print('inside bloc after api calling result/////////////// $results');
      }
      keyword=searchTerm;
      shortedList.clear();
      shortedList=[...results];
      shortedList.sort((a, b) => a.updatedAt.toString().compareTo(b.updatedAt.toString()));
      List<String> sortedListToJson = shortedList.map((repo) => jsonEncode(repo.toJson())).toList();






     // await sharedPreferences.setStringList(searchTerm, sortedListToJson);
   // await sessionManager.set(searchTerm, shortedList);


     if (kDebugMode) {
       print('shorted list name>>>>>>>>>>>> ${shortedList.map((e) => e.name)}');
     }
     //print('json Tags>>>>>>>>>>>> $sortedListToJson)}');

      emit(SearchStateSuccess(results));
    } catch (error) {
      emit(error is SearchStateError
          ? SearchStateError(error.error)
          : SearchStateError('something went wrong'));
    }
  }



  void _onSortedList(
      SortedList event,
      Emitter<GithubSearchState> emit,
      ) async {
   //  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   // // var sessionJson=await sessionManager.get(event.text);
   //  var sessionJson=await sharedPreferences.getStringList(event.text);
   //
   //  List<FlutterRepositoryModel> sortedSessionrepoList=  <FlutterRepositoryModel>[];
   //
   //  sortedSessionrepoList=  sessionJson!.map<FlutterRepositoryModel>((dynamic product) =>
   //      FlutterRepositoryModel.fromJson(product)).toList() ;
   //
   //  print("retrieve shared pref data >>>>>>>>>>>>>>>>>>> $sortedSessionrepoList");

    emit(SearchStateLoading());
    try {

      emit(SearchStateSuccess(isSorted?shortedList:shortedList));
    } catch (error) {
      emit(error is SearchStateError
          ? SearchStateError(error.error)
          : SearchStateError('something went wrong'));
    }
  }
}