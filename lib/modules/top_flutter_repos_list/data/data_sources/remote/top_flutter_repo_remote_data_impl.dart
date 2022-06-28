
import 'package:flutter/foundation.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/data/data_sources/remote/top_flutter_repo_remote_data.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/data/models/flutter_repository_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class FlutterRepoRemoteDataSourceImpl implements FlutterRepoRemoteDataSource{

  FlutterRepoRemoteDataSourceImpl(this.httpClient);

  final http.Client httpClient;

  @override
  Future<List<FlutterRepositoryModel>> getTopFlutterRepos({String? query}) async{




    // TODO: implement getTopFlutterRepos
    print("inside get search product >>>>>>>>>>>>>>>>> datasouec");
    print("inside get search product >>>>>>>>>>>>>>>>> $query");

    List<FlutterRepositoryModel> repoList;
    final response = await httpClient.get(
      Uri.https(
        'api.github.com',
        '/search/repositories',
        <String, String>{
          'q': query.toString(),
          'sort': 'stars',
          'order': 'desc',
          'page': '0',
          'per_page': '50'



        },
      ),
    );

    if (response.statusCode == 200) {
      print(response.statusCode);
      dynamic jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      print('jsonResponse $jsonResponse >>>>>>>>>>>>>>>>>>>>>>>>>ends');

      dynamic  searchRepoData = jsonResponse["items"];
      if (kDebugMode) {
        print('searchProductData>>>>>>>>>>>>>>>>>>>$searchRepoData');
      }

      repoList=  <FlutterRepositoryModel>[];
      repoList= searchRepoData.map<FlutterRepositoryModel>((dynamic product) =>
          FlutterRepositoryModel.fromJson(product)).toList() as List<FlutterRepositoryModel>;
      // productsList.addAll(searchProductData.data!.products!.results!);
      print('productsList>>>>>>>>>>>>>>>>>>>$repoList');
      return repoList;
    }
    throw Exception('error fetching posts');
  }




}