import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/presentation/bloc/github_search_bloc.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/presentation/views/pages/search_product_list.dart';
import '../widgets/custom_textfield.dart';

class TopFlutterRepoPage extends StatelessWidget {
  const TopFlutterRepoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children:  [

             const SizedBox(height: 50,),
            //Textield
             CustomTextField(),
            _SearchBody(),
          ],
        ),
      ),
    );
  }
}

class _SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GithubSearchBloc, GithubSearchState>(
      builder: (context, state) {

        if (state is SearchStateLoading) {
          return const CircularProgressIndicator();
        }
        if (state is SearchStateError) {
          return Text(state.error);
        }
        if (state is SearchStateSuccess) {

         int length=state.items.length;

         if (kDebugMode) {
           print('length>>>>> $length');
         }

          return state.items.isEmpty
              ? const Text('No Results')
              : Expanded(child: SearchProductList(items:state.items,len:length));
        }
        return const Text('Please enter a term to begin');
      },
    );
  }
}

