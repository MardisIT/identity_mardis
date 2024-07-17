import 'package:hive/hive.dart';
import 'package:identity_engine/core/infrastructure/base/userIndentity_ET.dart';


class UserIdentityAdapter extends TypeAdapter<Userindentity> {
  @override
  final int typeId = 1;

  @override
  Userindentity read(BinaryReader reader) {
    final id = reader.readString();
    final time = reader.readInt();
    final code = reader.readInt();
    final systemAplication = reader.readString();
    final email = reader.readString();
    final tenant = reader.readString();
     final addressMac = reader.readString();
    return Userindentity(id, time, code, systemAplication, email, tenant,addressMac);
  }

  @override
  void write(BinaryWriter writer, Userindentity obj) {
    writer.writeString(obj.id);
    writer.writeInt(obj.time);
    writer.writeInt(obj.code);
    writer.writeString(obj.systemAplication);
    writer.writeString(obj.email);
    writer.writeString(obj.tenant);
    writer.writeString( obj.addressMac);
  }
}