import 'package:tut/data/network/error_handler.dart';
import 'package:tut/data/response/responses.dart';

const cacheHomeKey = "cacheHomeKey";
const cacheHomeInterval = 60 * 1000;
const cacheDetailKey = "cacheDetailKey";
const cacheDetailInterval = 20 * 1000;

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();

  Future<void> saveHomeToCache(HomeResponse homeResponse);

  Future<DetailsResponse> getDetails();

  Future<void> saveDetailsToCache(DetailsResponse response);

  void clearCache();

  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  Map<String, CachedItem> cacheMap = {};

  @override
  Future<HomeResponse> getHomeData() async {
    CachedItem? cachedItem = cacheMap[cacheHomeKey];
    if (cachedItem != null && cachedItem.isValid(cacheHomeInterval)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[cacheHomeKey] = CachedItem(homeResponse);
  }

  @override
  Future<DetailsResponse> getDetails() async {
    CachedItem? cachedItem = cacheMap[cacheDetailKey];

    if (cachedItem != null && cachedItem.isValid(cacheDetailInterval)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> saveDetailsToCache(DetailsResponse response) async {
    cacheMap[cacheDetailKey] = CachedItem(response);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }
}

class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTimeInMillis) {
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;
    bool isValid = currentTimeInMillis - cacheTime <= expirationTimeInMillis;
    return isValid;
  }
}
