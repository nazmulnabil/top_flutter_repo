import 'package:top_flutter_repos/modules/top_flutter_repos_list/domain/entities/github_user.dart';

class GithubUserModel extends GithubUser{
  const GithubUserModel({required String login, required int id,
    required String avatarUrl, required String htmlUrl,
    required String url, required String reposUrl,
    required String type}) : super(login: login, id: id, avatarUrl: avatarUrl, htmlUrl: htmlUrl, url: url, reposUrl: reposUrl, type: type);

  factory GithubUserModel.fromJson(Map<String, dynamic> json) {
    return GithubUserModel(
      login: json['login'],
      id: json['id'],
      avatarUrl: json['avatarUrl'],
      htmlUrl: json['htmlUrl'],
      url: json['url'],
      reposUrl: json['reposUrl'],
      type: json['type'],
    );
  }
}