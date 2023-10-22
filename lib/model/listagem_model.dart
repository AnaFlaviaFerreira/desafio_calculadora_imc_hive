import 'package:hive/hive.dart';

part 'listagem_model.g.dart';

@HiveType(typeId: 0)
class ListagemModel extends HiveObject {
  @HiveField(0)
  double? peso;

  @HiveField(1)
  double? imc;

  ListagemModel();

  ListagemModel.criar(this.peso, this.imc);
}
