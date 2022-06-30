import 'package:hive/hive.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/data/data_sources/local/top_flutter_repo_cache.dart';

class TopFlutterRepoCacheImpl extends TopFlutterRepoCache{
  final box= Hive.box('cacheResponse');

  @override
  get() async{
    // TODO: implement get
    return await Hive.box('cacheResponse').get('cacheResponse', defaultValue: []);

  }

  @override
  set({required String apiResponse}) async{
    // TODO: implement set
    await Hive.box('cacheResponse').clear();
    await Hive.box('cacheResponse').put('cacheResponse',apiResponse);
  }

}
