
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/data/data_sources/remote/top_flutter_repo_remote_data.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/data/models/flutter_repository_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../local/top_flutter_repo_cache.dart';
class FlutterRepoRemoteDataSourceImpl implements FlutterRepoRemoteDataSource{

   FlutterRepoRemoteDataSourceImpl({required this.httpClient,required this.topFlutterRepoCache});

   final http.Client httpClient;
   final  TopFlutterRepoCache topFlutterRepoCache;

   final String baseUrl = "api.github.com";
   final box= Hive.box('cacheResponse');

  @override
  Future<List<FlutterRepositoryModel>> getTopFlutterRepos({ String? query}) async{

    // TODO: implement getTopFlutterRepos

    if (kDebugMode) {
      print("inside remote impl >>>>> query >>>>>>>>>>>>>>>>> $query");
    }

    try {
      var response =await httpClient.get(
    Uri.https(baseUrl, '/search/repositories', {
    'q': query,
    'sort': 'stars',
    'order': 'desc',
    'per_page': '50'
    })
    );
      if (response.statusCode == 200) {

        dynamic jsonResponse = json.decode(utf8.decode(response.bodyBytes));


     await  topFlutterRepoCache.set( key: query.toString(),apiResponse: jsonResponse["items"],);
     // await box.put(query, jsonResponse['items']);
      }
    } catch (e) {
      print('Exception!!!!!!!!!!!!!!!!!!!!!!!!  ${e.toString()}');
    }
    ///
    var cachedJson = await topFlutterRepoCache.get(key: query.toString());
    //var cachedJson = await box.get(query);

    if (kDebugMode) {
      print("inside remote impl >>>>> cachrd json >>>>>>>>>>>>>>>>> $cachedJson");
    }

    List<FlutterRepositoryModel> repoList=  <FlutterRepositoryModel>[];

        repoList= cachedJson.map<FlutterRepositoryModel>((dynamic product) =>
        FlutterRepositoryModel.fromJson(product)).toList() as List<FlutterRepositoryModel>;

    if (kDebugMode) {
      print('repo List>>>>>>>>>>>>>>>>>>>$repoList');
    }
    if (kDebugMode) {
      print('repo length>>>>>>>>>>>>>>>>>>>${repoList.length}');
    }
    return repoList;

  }

}




