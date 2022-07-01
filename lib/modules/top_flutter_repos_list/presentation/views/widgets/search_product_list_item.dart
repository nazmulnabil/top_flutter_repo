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
      margin: EdgeInsets.only(left: 15,bottom: 5,top: 5),
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        //border: BorderRadius(),
      ),


      //item.owner!.avatarUrl.toString()
      child: ListTile(
        leading: CircleAvatar(
          //radius: ,
          child: CachedNetworkImage(
            imageUrl: item.owner!.avatarUrl.toString(),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                  // colorFilter: const ColorFilter.mode(Colors.white, BlendMode.colorBurn)
                ),
              ),
            ),
            placeholder:(context, url) =>  const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>  const Icon(Icons.error),
          ),
        ),
        trailing:Container(
          width:70,
          child: Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [

              Icon(Icons.star,size: 18,
              color: Colors.amber,),
              Text(item.stargazersCount.toString(),
              style: TextStyle(
                fontSize:14
              ),),

            ],
          ),
        ),
        title: Text(item.fullName.toString()),
        subtitle: Text('updated at '+DateFormat('MM-dd-yy hh:ss').format(DateTime.parse(item.updatedAt.toString()))),
        onTap: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  RepoDetailsPage(repositoryModel: item,)));

        },
      ),
    );
  }
}
