import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/data/models/flutter_repository_model.dart';

import '../../../../../core/app_colors.dart';
import '../../../../repo_details_page/presentation/views/pages/repo_details_page.dart';
import 'bottom_loader.dart';

class SearchProductListItem extends StatelessWidget {
  const SearchProductListItem({Key? key, required this.item, required this.index}) : super(key: key);

  final FlutterRepositoryModel item;
  final int index;


  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;

    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        //border: BorderRadius(),
      ),

      child: ListTile(
        leading: CircleAvatar(
          child: Image.network(item.owner!.avatarUrl.toString()),
        ),
        trailing:Text(item.stargazersCount.toString()),
        title: Text(item.fullName.toString()),
        subtitle: Text('updated at '+DateFormat('MM-dd-yy hh:ss').format(DateTime.parse(item.updatedAt.toString()))),
        onTap: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  RepoDetailsPage(repositoryModel: item,)));
         
        },
      ),
    );
  }
}
