// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listagem_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListagemModelAdapter extends TypeAdapter<ListagemModel> {
  @override
  final int typeId = 0;

  @override
  ListagemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListagemModel()
      ..peso = fields[0] as double?
      ..imc = fields[1] as double?;
  }

  @override
  void write(BinaryWriter writer, ListagemModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.peso)
      ..writeByte(1)
      ..write(obj.imc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListagemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
