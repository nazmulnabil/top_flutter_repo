
import 'package:flutter/foundation.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/data/data_sources/remote/top_flutter_repo_remote_data.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/data/models/flutter_repository_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class FlutterRepoRemoteDataSourceImpl implements FlutterRepoRemoteDataSource{

   FlutterRepoRemoteDataSourceImpl(this.httpClient);

   final http.Client httpClient;
   final String baseUrl = "api.github.com";

  @override
  Future<List<FlutterRepositoryModel>> getTopFlutterRepos({ String? query}) async{

    // TODO: implement getTopFlutterRepos

    if (kDebugMode) {
      print("inside remote impl >>>>> query >>>>>>>>>>>>>>>>> $query");
    }

    List<FlutterRepositoryModel> repoList;
    final response = await httpClient.get(
        Uri.https(baseUrl, '/search/repositories', {
          'q': query,
          'sort': 'stars',
          'order': 'desc',
          'per_page': '50'
        })
  );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.statusCode);
      }
      dynamic jsonResponse = json.decode(utf8.decode(response.bodyBytes));

      if (kDebugMode) {
        print('jsonResponse $jsonResponse >>>>>>>>>>>>>>>>>>>>>>>>>ends');
      }
      dynamic  searchRepoData = jsonResponse["items"];
      if (kDebugMode) {
        print('search results items>>>>>>>>>>>>>>>>>>>$searchRepoData');
      }

      repoList=  <FlutterRepositoryModel>[];
      repoList= searchRepoData.map<FlutterRepositoryModel>((dynamic product) =>
      FlutterRepositoryModel.fromJson(product)).toList() as List<FlutterRepositoryModel>;
      // productsList.addAll(searchProductData.data!.products!.results!);
      if (kDebugMode) {
        print('repo List>>>>>>>>>>>>>>>>>>>$repoList');
      }
      if (kDebugMode) {
        print('repo length>>>>>>>>>>>>>>>>>>>${repoList.length}');
      }
      return repoList;
    }
    throw Exception('error fetching data');
  }




}