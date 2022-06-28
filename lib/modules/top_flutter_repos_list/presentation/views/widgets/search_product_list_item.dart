import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:top_flutter_repos/modules/top_flutter_repos_list/data/models/flutter_repository_model.dart';

import '../../../../../core/app_colors.dart';
import 'bottom_loader.dart';

class SearchProductListItem extends StatefulWidget {
  const SearchProductListItem({Key? key, required this.item, required this.index}) : super(key: key);

  final FlutterRepositoryModel item;
  final int index;

  @override
  State<SearchProductListItem> createState() => _SearchProductListItemState();
}

class _SearchProductListItemState extends State<SearchProductListItem> {


  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;

    return  ListTile(
      leading: CircleAvatar(
        child: Image.network(widget.item.owner.avatarUrl),
      ),
      title: Text(widget.item.fullName),
      onTap: () async {


      },
    );
  }
}
