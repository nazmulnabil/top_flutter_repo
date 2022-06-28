import 'package:top_flutter_repos/modules/top_flutter_repos_list/data/models/github_user_model.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/domain/entities/github_user.dart';

import '../../domain/entities/flutter_project.dart';

class FlutterRepositoryModel extends FlutterProject{
  const FlutterRepositoryModel({required int id, required String name, required String fullName,
    required GithubUser owner, required String description, required String createdAt, required String updatedAt,
    required int size, required int stargazersCount, required int watchersCount,
    required String? language, required int forksCount, required int openIssuesCount})
      : super(id: id, name: name, fullName: fullName,
       owner: owner, description: description, createdAt: createdAt,
       updatedAt: updatedAt, size: size, stargazersCount:
       stargazersCount, watchersCount: watchersCount,
       language: language, forksCount: forksCount, openIssuesCount: openIssuesCount);


  factory FlutterRepositoryModel.fromJson(Map<String, dynamic> json) {
    return FlutterRepositoryModel(
       id: json['id'],
       name: json['name'],
      fullName: json['fullName'],
      owner:json['owner']?GithubUserModel.fromJson(json['owner']):null as GithubUser,
      description: json['description'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      size: json['size'],
      stargazersCount: json['stargazersCount'],
      watchersCount: json['watchersCount'],
      language: json['language'],
      forksCount: json['forksCount'],
      openIssuesCount: json['openIssuesCount'],
    );
  }

}