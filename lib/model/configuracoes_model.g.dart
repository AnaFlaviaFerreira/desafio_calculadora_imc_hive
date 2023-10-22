// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuracoes_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConfiguracoesModelAdapter extends TypeAdapter<ConfiguracoesModel> {
  @override
  final int typeId = 1;

  @override
  ConfiguracoesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConfiguracoesModel()
      ..nome = fields[0] as String?
      ..altura = fields[1] as double?
      ..genero = fields[2] as String?
      ..showMainPage = fields[3] as bool?;
  }

  @override
  void write(BinaryWriter writer, ConfiguracoesModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.nome)
      ..writeByte(1)
      ..write(obj.altura)
      ..writeByte(2)
      ..write(obj.genero)
      ..writeByte(3)
      ..write(obj.showMainPage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfiguracoesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
