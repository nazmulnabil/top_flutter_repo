import 'package:equatable/equatable.dart';

class GithubUser extends Equatable {
  final String login;
  final  int id;
  final String avatarUrl;
  final String htmlUrl;
  final String url;
  final  String reposUrl;
  final String type;

     const GithubUser ({
    required this.login,
    required  this.id,
    required this.avatarUrl,
    required this.htmlUrl,
    required this.url,
    required this.reposUrl,
    required this.type
  });

  @override
  List<Object?> get props => [login,id,avatarUrl,htmlUrl,url,reposUrl,type];
}