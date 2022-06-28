import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/data/models/flutter_repository_model.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/presentation/bloc/github_search_bloc.dart';
import '../widgets/bottom_loader.dart';
import '../widgets/search_product_list_item.dart';

class SearchProductList extends StatefulWidget {
  const SearchProductList({Key? key, required this.items, required this.len}) : super(key: key);

 final List<FlutterRepositoryModel> items;
 final int len;


  @override
  State<SearchProductList> createState() => _SearchProductListState();
}

class _SearchProductListState extends State<SearchProductList> {

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {

    final GithubSearchBloc searchProductBloc=context.read<GithubSearchBloc>();

   // final width=MediaQuery.of(context).size.width;
    print("items >>>>>>>>>>>>>>> ${widget.items}");
    print("len >>>>>>>>> ${widget.len}");
    return  ListView.builder(
        itemCount:widget.len,

        itemBuilder: (BuildContext ctx, index) {
          return SearchProductListItem(item: widget.items[index], index: index,);


        });
  }

  @override
  void dispose() {

    super.dispose();
  }




}

