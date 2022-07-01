

import 'package:flutter/foundation.dart';
import '../../domain/repository/top_flutter_repo_repository.dart';
import '../data_sources/remote/top_flutter_repo_remote_data.dart';
import '../models/flutter_repository_model.dart';

class TopFlutterRepoRepositoryImpl extends ITopFlutterRepoRepository{

  final FlutterRepoRemoteDataSource _flutterRepoRemoteDataSource;



  TopFlutterRepoRepositoryImpl(this._flutterRepoRemoteDataSource);

  @override
  Future<List<FlutterRepositoryModel>> searchTopFlutterRepos({String? term}) async{
    // TODO: implement search
    if (kDebugMode) {
      print('inside repo before  api call term  $term');
    }
    final result = await _flutterRepoRemoteDataSource.getTopFlutterRepos(query: term.toString(),);

      if (kDebugMode) {
        print('inside repo after api call term  $term');
      }

    return result;
  }
  
  
  
  
}