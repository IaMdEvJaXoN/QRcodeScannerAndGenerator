import 'package:hive/hive.dart';
import 'package:proscan/Features/ScanQR/Domain/Entity/entity.dart';

class ScanModel extends HiveObject {
  final int id;
  final Map<dynamic, dynamic> payLoad;
  final String contentType;
  final String timeStamp;

  ScanModel({
    required this.id,
    required this.payLoad,
    required this.contentType,
    required this.timeStamp,
  });

  factory ScanModel.fromEntityToModel(ScanHistoryEntity entity) {
    return ScanModel(
      id: entity.id,
      payLoad: entity.payLoad,
      contentType: entity.contentType,
      timeStamp: entity.timeStamp,
    );
  }

  ScanHistoryEntity toEntityFromModel() {
    return ScanHistoryEntity(
      id: id,
      payLoad: Map<String, String>.from(payLoad),
      contentType: contentType,
      timeStamp: timeStamp,
    );
  }
}

//I am using  a manual adapter
//Due to version compatibility issues,using hive generator is not the goto here.
//The class below does what hive_generator does

class ScanModelAdapter extends TypeAdapter<ScanModel> {
  @override
  final int typeId = 1; //Unique id for this model

  @override
  ScanModel read(BinaryReader reader) {
    //Properties are in the exact order defined in the Model Class
    return ScanModel(
      id: reader.readInt(),
      payLoad: reader.readMap(),
      contentType: reader.readString(),
      timeStamp: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, ScanModel obj) {
    //Props in the exact same order as when reading
    writer.writeInt(obj.id);
    writer.writeMap(obj.payLoad);
    writer.writeString(obj.contentType);
    writer.writeString(obj.timeStamp);
  }
}
