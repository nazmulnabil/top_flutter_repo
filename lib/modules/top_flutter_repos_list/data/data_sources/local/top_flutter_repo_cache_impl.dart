import 'package:hive/hive.dart';
import 'package:top_flutter_repos/modules/top_flutter_repos_list/data/data_sources/local/top_flutter_repo_cache.dart';

class TopFlutterRepoCacheImpl extends TopFlutterRepoCache{






  @override
  get({required String key})async {
    // TODO: implement get
    print('inside get method');
    final box= Hive.box('cacheResponse');
    return await box.get(key.toString());
  }

  @override
  set({required String key, required String apiResponse}) async{
    // TODO: implement set
    print('inside save method');
    final box= Hive.box('cacheResponse');
    return await box.put(key.toString(),apiResponse);
  }

}
