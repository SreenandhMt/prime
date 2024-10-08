
import 'package:hive_flutter/hive_flutter.dart';
import 'package:main_work/features/account/data/module/account_favorits_module.dart';
import 'package:main_work/features/account/domain/entities/account_favorit_entities.dart';

class AccountFavoritDataSources {
  Future<List<AccountFavoritDataEntities>>getData()async{
      try {
        final box = await Hive.openBox("favorits");
    final value = box.values.toList();
    return value.map((e) => AccountFavoritData.formjson(e)).toList();
      } catch (e) {
        return [];
      }
  }

  Future<List<AccountFavoritDataEntities>>addData(Map map)async{
    final box = await Hive.openBox("favorits");
    await box.put(map["productId"], map);
    return await getData();
  }
  Future<List<AccountFavoritDataEntities>> deleteData(String productId)async{
     try {
      final box = await Hive.openBox("favorits");
    await box.delete(productId);
    return await getData();
    } catch (e) {
      return await getData();
    }
  }
}