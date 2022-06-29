import '../../data/models/flutter_repository_model.dart';
import '../entities/flutter_project.dart';
import '../repository/top_flutter_repo_repository.dart';

class GetTopFlutterRepos {
  ITopFlutterRepoRepository flutterRepoRepository;

  GetTopFlutterRepos({required this.flutterRepoRepository});

  Future<List<FlutterRepositoryModel>> fetchTopFlutterRepos({required String? term}) async{
    // TODO: implement search
    print('inside use case  ');
    print('inside repo after api term  $term');
     return  await flutterRepoRepository.searchTopFlutterRepos(term: term.toString() );
  }
}