import 'package:hive/hive.dart';

part 'configuracoes_model.g.dart';

@HiveType(typeId: 1)
class ConfiguracoesModel extends HiveObject {
  @HiveField(0)
  String? nome;

  @HiveField(1)
  double? altura;

  @HiveField(2)
  String? genero;

  @HiveField(3)
  bool? showMainPage;

  ConfiguracoesModel();

  ConfiguracoesModel.vazio() {
    nome = "";
    altura = 0;
    genero = "";
    showMainPage = false;
  }
}
