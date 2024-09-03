import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Userindentity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final int time;
  @HiveField(2)
  final int code;
  @HiveField(3)
  final String systemAplication;
  @HiveField(4)
  final String email;
  @HiveField(5)
  final String tenant;
  @HiveField(6)
  final String addressMac;
  // @HiveField(7)
  // final String device;
  Userindentity(
    this.id,
    this.time,
    this.code,
    this.systemAplication,
    this.email,
    this.tenant,
    this.addressMac,
    // this.device,
  );
}
