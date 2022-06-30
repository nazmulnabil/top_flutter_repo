import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:top_flutter_repos/modules/top_flutter_repos_list/data/data_sources/local/top_flutter_repo_cache_impl.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/data/data_sources/remote/top_flutter_repo_remote_data.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/data/data_sources/remote/top_flutter_repo_remote_data_impl.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/data/repositories/top_flutter_repo_repository_impl.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/domain/use_cases/get_top_flutter_repo_list.dart';
import 'package:top_flutter_repos/simple_bloc_observer.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'modules/top_flutter_repos_list/data/data_sources/local/top_flutter_repo_cache.dart';
import 'modules/top_flutter_repos_list/domain/repository/top_flutter_repo_repository.dart';






void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var box = await Hive.openBox('cacheResponse');
  TopFlutterRepoCache topFlutterRepoCache=TopFlutterRepoCacheImpl();
  FlutterRepoRemoteDataSource flutterRepoRemoteDataSource=FlutterRepoRemoteDataSourceImpl( topFlutterRepoCache: topFlutterRepoCache,httpClient: http.Client());
  ITopFlutterRepoRepository topFlutterRepoRepository=TopFlutterRepoRepositoryImpl(flutterRepoRemoteDataSource);
  GetTopFlutterRepos getTopFlutterRepos=GetTopFlutterRepos(flutterRepoRepository: topFlutterRepoRepository);
  BlocOverrides.runZoned(

        () => runApp(App(getTopFlutterRepos: getTopFlutterRepos,)),
    blocObserver: SimpleBlocObserver(),
  );
}



