import 'package:hive/hive.dart';
import 'package:identity_engine/core/infrastructure/base/userIndentity_ET.dart';

class Useridentityservice { 

final String boxName = 'useridentity';
  Future<Box<Userindentity>> get box async => Hive.openBox<Userindentity>(boxName);

  Future<void> add(Userindentity useridentity) async {
    final box = await this.box;
    await box.add(useridentity);
  }
  Future <void> update(Userindentity useridentity) async {
    final box = await this.box;
    await box.put(useridentity.id, useridentity);
  }
  Future<void> delete(Userindentity useridentity) async {
    final box = await this.box;
    await box.delete(useridentity.id);
  }
Future<List<Userindentity>> getAll() async {
    final box = await this.box;
    return box.values.toList();
  }
  Future<Userindentity?> getById(String id) async {
    final box = await this.box;
    return box.get(id);
  }
  Future<void> deleteAll() async {
    final box = await this.box;
    await box.clear();
  }
  Future<void> close() async {
    final box = await this.box;
    await box.close();
  }  

}