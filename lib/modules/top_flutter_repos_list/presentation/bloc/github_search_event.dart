part of 'github_search_bloc.dart';



abstract class GithubSearchEvent extends Equatable {
  const GithubSearchEvent();
}

class TextChanged extends GithubSearchEvent {
  const TextChanged({required this.text});

  final String text;

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'TextChanged { text: $text }';
}

class SortedList extends GithubSearchEvent {
  const SortedList( {required this.text});
  final String text;

  @override
  List<Object> get props => [text];

  @override
  String toString() => 'list shorted { shorted list: $text }';
}

class OnRefreshApi extends GithubSearchEvent {
  const OnRefreshApi();
  @override
  List<Object> get props => [];

  @override
  String toString() => 'TextChanged { text:  }';
}