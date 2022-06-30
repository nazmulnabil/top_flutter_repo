import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/presentation/bloc/github_search_bloc.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/presentation/views/pages/search_product_list.dart';
import '../../../../../core/app_colors.dart';
import '../widgets/custom_textfield.dart';

class TopFlutterRepoPage extends StatelessWidget {
  const TopFlutterRepoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        body: Column(
          children:  [

             const SizedBox(height: 20,),



        TextButton(
          style: TextButton.styleFrom(onSurface: AppColors.lightGreyColor),
          onPressed: () { context.read<GithubSearchBloc>().isSorted=!(context.read<GithubSearchBloc>().isSorted);
          context.read<GithubSearchBloc>().add(SortedList(text: context.read<GithubSearchBloc>().keyword));


            },
          child:
     Container(
       padding: EdgeInsets.all(5),
            height: 30,

            //margin: EdgeInsets.symmetric(horizontal: 4.0),
            decoration: const BoxDecoration(
                color:AppColors.colorPrimary ,
                // border: Border.all(
                //   color: Colors.red,
                // ),
                borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            child:Container(
              width: MediaQuery.of(context).size.width/3,
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children:const [
                  Text('Sort by date ',
                  style: TextStyle(
                    color: AppColors.colorWhite
                  ),),

                  Icon( Icons.sort,
                  color: AppColors.colorWhite,)
                ],
              ),
            )
          )

        ),
        const SizedBox(height:20,),
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

