import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:top_flutter_repos/core/app_colors.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/data/models/flutter_repository_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
class RepoDetailsPage extends StatelessWidget {
  const RepoDetailsPage({Key? key,required this.repositoryModel}) : super(key: key);

 final FlutterRepositoryModel repositoryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Repository User Details'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,


      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: Column(
            children: [

              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),

                height: MediaQuery.of(context).size.width/2,
                width: MediaQuery.of(context).size.width*0.9,
                child:ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: repositoryModel.owner!.avatarUrl.toString(),
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
              ),

              const SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text("name:",
                          style:  TextStyle(
                              fontSize:18 ,
                              overflow: TextOverflow.ellipsis
                          ),),
                        const SizedBox(width: 2,),
                        Text(repositoryModel.owner!.login.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize:17 ,
                            // overflow: TextOverflow.ellipsis
                          ),),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("descripton:",
                          style:  TextStyle(
                              fontSize:18 ,
                              overflow: TextOverflow.ellipsis
                          ),),
                        const SizedBox(width: 2,),
                        Text(repositoryModel.description.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w300,
                             fontSize:17 ,
                             // overflow: TextOverflow.ellipsis
                          ),),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        const Text("updated at:",
                          style:  TextStyle(
                              fontSize:18 ,
                              overflow: TextOverflow.ellipsis
                          ),),
                        const SizedBox(width: 2,),

                        Text( DateFormat('MM-dd-yy hh:ss').format(DateTime.parse(repositoryModel.updatedAt.toString())),
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize:17 ,
                            // overflow: TextOverflow.ellipsis
                          ),),
                      ],
                    ),

                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        const Text("Total stars:",
                          style:  TextStyle(
                              fontSize:18 ,
                              overflow: TextOverflow.ellipsis
                          ),),
                        const SizedBox(width: 2,),
                        Expanded(child: Text(repositoryModel.stargazersCount.toString(),
                          style: const TextStyle(
                              color: Colors.orange,

                              fontSize:17 ,
                              overflow: TextOverflow.ellipsis
                          ),)
                          ,)

                      ],
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        const Text("Url:",
                          style: TextStyle(
                              fontSize:18 ,
                          ),),
                        const SizedBox(width: 2,),
                        Expanded(
                          child: Text(repositoryModel.url.toString(),
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontSize:17 ,
                              //  overflow: TextOverflow.ellipsis
                            ),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),





            ],
          ),
        ),
      ),
    );
  }
}
