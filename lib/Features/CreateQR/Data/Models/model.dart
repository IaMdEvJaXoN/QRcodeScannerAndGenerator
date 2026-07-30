import 'package:hive_flutter/adapters.dart';
import 'package:proscan/Features/CreateQR/Domain/Entity/entity.dart';

//Extending HiveObject--An object in app's memory is directly linked to the physical location in memory.
class GeneratedQrModel extends HiveObject {
  final int id;
  final String content;
  final String contentType;
  final String timeStamp;
  GeneratedQrModel({
    required this.id,
    required this.content,
    required this.contentType,
    required this.timeStamp,
  });

  factory GeneratedQrModel.fromEntityToModel(GeneratedQrHistoryEntity entity) {
    return GeneratedQrModel(
      id: entity.id,
      content: entity.payLoad,
      contentType: entity.qrType,
      timeStamp: entity.timeStamp,
    );
  }
  GeneratedQrHistoryEntity toEntityFromModel() {
    return GeneratedQrHistoryEntity(
      id: id,
      payLoad: content,
      qrType: contentType,
      timeStamp: timeStamp,
    );
  }
}

//Manual Hive Adapter creation
class GeneratedModelAdapter extends TypeAdapter<GeneratedQrModel> {
  @override
  final int typeId = 2;

  //De-serialization
  @override
  GeneratedQrModel read(BinaryReader reader) {
    return GeneratedQrModel(
      id: reader.readInt(),
      content: reader.readString(),
      contentType: reader.readString(),
      timeStamp: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, GeneratedQrModel obj) {
    //serialization
    writer.writeInt(obj.id);
    writer.writeString(obj.content);
    writer.writeString(obj.contentType);
    writer.writeString(obj.timeStamp);
  }
}
