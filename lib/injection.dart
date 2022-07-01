

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:top_flutter_repos/modules/top_flutter_repos_list/data/data_sources/remote/top_flutter_repo_remote_data_impl.dart';

import 'modules/top_flutter_repos_list/data/data_sources/local/top_flutter_repo_cache.dart';
import 'modules/top_flutter_repos_list/data/data_sources/local/top_flutter_repo_cache_impl.dart';
import 'modules/top_flutter_repos_list/data/data_sources/remote/top_flutter_repo_remote_data.dart';
import 'modules/top_flutter_repos_list/data/repositories/top_flutter_repo_repository_impl.dart';
import 'modules/top_flutter_repos_list/domain/repository/top_flutter_repo_repository.dart';
import 'modules/top_flutter_repos_list/domain/use_cases/get_top_flutter_repo_list.dart';
import 'modules/top_flutter_repos_list/presentation/bloc/github_search_bloc.dart';


final locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(
          () => GithubSearchBloc(getTopFlutterRepos: locator.get<GetTopFlutterRepos>()
        //searchProductRepository: locator.get<SearchProductRepository>(),

          )
  );




  ///use cases
  locator.registerLazySingleton<GetTopFlutterRepos>(
          () => GetTopFlutterRepos(flutterRepoRepository: locator.get<ITopFlutterRepoRepository>()));


  ///repositories
  locator.registerLazySingleton<ITopFlutterRepoRepository>(
        () => TopFlutterRepoRepositoryImpl(locator.get<FlutterRepoRemoteDataSource>()),

  );

  ///data source
  locator.registerLazySingleton<FlutterRepoRemoteDataSource>(
        () => FlutterRepoRemoteDataSourceImpl(httpClient: http.Client(),
             topFlutterRepoCache: locator.get<TopFlutterRepoCache>()),
  );
  locator.registerLazySingleton<TopFlutterRepoCache>(
        () => TopFlutterRepoCacheImpl(),
  );


}