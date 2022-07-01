import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/presentation/bloc/github_search_bloc.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/presentation/views/pages/search_product_list.dart';
import '../../../../../core/app_colors.dart';
import '../widgets/custom_textfield.dart';

class TopFlutterRepoPage extends StatefulWidget {
  const TopFlutterRepoPage({Key? key}) : super(key: key);

  @override
  State<TopFlutterRepoPage> createState() => _TopFlutterRepoPageState();
}

class _TopFlutterRepoPageState extends State<TopFlutterRepoPage> {

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1800), (Timer t)
    =>context.read<GithubSearchBloc>().add(const OnRefreshApi()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.pageBackground,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.pageBackground,
          body: Column(
            children:  [

               const SizedBox(height: 20,),


/// sorting button ///

          const SizedBox(height:20,),
              //Textield
               CustomTextField(),
              _SearchBody(),
            ],
          ),
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
             : 
         Expanded(
             child: Column(
           children: [

             TextButton(
                 style: TextButton.styleFrom(onSurface: AppColors.lightGreyColor),
                 onPressed: () { context.read<GithubSearchBloc>().isSorted=!(context.read<GithubSearchBloc>().isSorted);
                 context.read<GithubSearchBloc>().add(SortedList(text: context.read<GithubSearchBloc>().keyword));


                 },
                 child:
                 Container(
                   height: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      color:Colors.lightBlue
                    ),
                   width: MediaQuery.of(context).size.width/2,
                   child: Row(mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(context.read<GithubSearchBloc>().isSorted?'Default':'Sort by DateTime',
                         style: TextStyle(
                             color: AppColors.colorWhite
                         ),),

                       SizedBox(width: 5,),

                       Icon( Icons.sort,
                         color: AppColors.colorWhite,
                       size: 17,)
                     ],
                   ),
                 )

             ),
             Expanded(child: SearchProductList(items:state.items,len:length))
           ],
         ));
        }
        return const Text('Please enter a term to begin');
      },
    );
  }
}

