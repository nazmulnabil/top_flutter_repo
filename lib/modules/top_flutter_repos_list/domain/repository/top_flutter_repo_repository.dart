

import 'package:top_flutter_repos/modules/top_flutter_repos_list/data/models/flutter_repository_model.dart';

import '../entities/flutter_project.dart';

abstract class ITopFlutterRepoRepository {
  Future<List<FlutterRepositoryModel>>  searchTopFlutterRepos({required String term});

}