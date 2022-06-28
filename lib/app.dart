
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/presentation/bloc/github_search_bloc.dart';

import 'modules/top_flutter_repos_list/domain/use_cases/get_top_flutter_repo_list.dart';
import 'modules/top_flutter_repos_list/presentation/views/pages/top_repo_list_page.dart';



class App extends StatelessWidget {
   App({Key? key,required this.getTopFlutterRepos }) : super(key: key);

  GetTopFlutterRepos getTopFlutterRepos;

  @override
  Widget build(BuildContext context) {
    return
      // MultiBlocProvider(
      //
      //   providers: [
      //     BlocProvider(
      //       create: (_) => SearchProductBloc(
      //           searchProductRepository: searchProductRepository),
      //     ),
      //     BlocProvider(
      //       create: (_) => CartBloc(
      //         shoppingRepository: shoppingRepository,
      //       )..add(CartStarted()),
      //     )
      //   ],
      //   child: const SearchProductPage(),
      // ),
      MultiBlocProvider(

        providers: [
          BlocProvider(
            create: (_) => GithubSearchBloc(getTopFlutterRepos: getTopFlutterRepos
             ),
          ),

        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
           home: TopFlutterRepoPage(),
        ),
      )
   ;

  }
}
