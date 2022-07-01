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
      height:width/4,
      margin: const EdgeInsets.only(left: 15,bottom: 5,top: 5,right: 15),
      decoration: const BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),

      ),


      //item.owner!.avatarUrl.toString()
      child: Center(
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
                  ),
                ),
              ),
              placeholder:(context, url) =>  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>  const Icon(Icons.error),
            ),
          ),
          trailing:SizedBox(
            width:70,
            child: Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children: [

                const Icon(Icons.star,size: 18,
                color: Colors.amber,),
                Text(item.stargazersCount.toString(),
                style: const TextStyle(
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
      ),
    );
  }
}
