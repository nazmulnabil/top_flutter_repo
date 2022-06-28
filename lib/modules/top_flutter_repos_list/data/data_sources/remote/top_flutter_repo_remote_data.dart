

import '../../models/flutter_repository_model.dart';

abstract class FlutterRepoRemoteDataSource {
  Future<List<FlutterRepositoryModel>> getTopFlutterRepos({String query});
}
