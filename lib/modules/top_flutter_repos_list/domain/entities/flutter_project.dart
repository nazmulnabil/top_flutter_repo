

import 'dart:core';

import 'package:equatable/equatable.dart';

import 'github_user.dart';

class FlutterProject extends Equatable{


  final int id;
  final String name;
  final  String fullName;
  final GithubUser  owner;
  final String description;
  final String createdAt;
  final   String updatedAt;
  final int size;
  final  int stargazersCount;
  final int watchersCount;
  final   String? language;
  final int forksCount;
  final  int openIssuesCount;


  const FlutterProject({
        required this.id,
        required this.name,
        required this.fullName,
        required  this.owner,
        required  this.description,
        required  this.createdAt,
        required this.updatedAt,
        required this.size,
        required  this.stargazersCount,
        required  this.watchersCount,
        required this.language,
        required  this.forksCount,
        required  this.openIssuesCount
        });

  @override
  // TODO: implement props
  List<Object?> get props => [id,name,fullName,owner,description,createdAt,updatedAt,
    size,stargazersCount,watchersCount,watchersCount,language,forksCount,openIssuesCount];




}

