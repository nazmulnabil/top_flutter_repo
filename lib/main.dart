import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/domain/use_cases/get_top_flutter_repo_list.dart';
import 'package:top_flutter_repos/simple_bloc_observer.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'injection.dart';
import 'modules/top_flutter_repos_list/domain/repository/top_flutter_repo_repository.dart';
import 'injection.dart' as di;





void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await Hive.initFlutter();
  var box = await Hive.openBox('cacheResponse');
  ITopFlutterRepoRepository topFlutterRepoRepository=locator.get<ITopFlutterRepoRepository>();
  GetTopFlutterRepos getTopFlutterRepos=GetTopFlutterRepos(flutterRepoRepository: topFlutterRepoRepository);
  BlocOverrides.runZoned(
        () => runApp(App(getTopFlutterRepos: getTopFlutterRepos,)),
    blocObserver: SimpleBlocObserver(),
  );
}



