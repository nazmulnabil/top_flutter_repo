

import 'package:top_flutter_repos/modules/top_flutter_repos_list/data/data_sources/local/top_flutter_repo_cache_impl.dart';
import '../../domain/repository/top_flutter_repo_repository.dart';
import '../data_sources/remote/top_flutter_repo_remote_data.dart';
import '../models/flutter_repository_model.dart';

class TopFlutterRepoRepositoryImpl extends ITopFlutterRepoRepository{

  final FlutterRepoRemoteDataSource _flutterRepoRemoteDataSource;
  final TopFlutterRepoCache _topFlutterRepoCache;


  TopFlutterRepoRepositoryImpl(this._flutterRepoRemoteDataSource,this._topFlutterRepoCache);

  @override
  Future<List<FlutterRepositoryModel>> searchTopFlutterRepos({String? term}) async{
    // TODO: implement search
    print('inside repo after api term  $term');
    final result = await _flutterRepoRemoteDataSource.getTopFlutterRepos(query: term.toString(),);
      print('inside repo after api calling ');
      print('inside repo after api term  $term');

    return result;
  }
  
  
  
  
}