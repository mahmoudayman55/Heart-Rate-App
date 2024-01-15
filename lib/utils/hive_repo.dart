import 'dart:convert';

import 'package:hive/hive.dart';

import 'local_entiry.dart';

class LocalEntityRepository {

  final String boxName;

  LocalEntityRepository(this.boxName);

  Future<void> createOrUpdate(LocalEntity data) async {
    await Hive.box<String>(boxName)
        .put(data.key, jsonEncode(data));
  }
  List<T> getAllEntities<T extends LocalEntity>() {
    final data = Hive.box<String>(boxName).values.map((e) {
      return LocalEntity.fromJson(T, Map<String, dynamic>.from(jsonDecode(e)));
    }).toList();
    return List<T>.from(data);
  }

  Future<void> deleteData(String id) async {
    Hive.box<String>(boxName).delete(id);
  }


}