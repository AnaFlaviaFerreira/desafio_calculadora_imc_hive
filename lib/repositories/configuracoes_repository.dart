import 'package:desafio_calculadora_imc_hive/model/configuracoes_model.dart';
import 'package:hive/hive.dart';

class ConfiguracoesRepository {
  static late Box _box;
  static String _chave = "configuracoes";

  ConfiguracoesRepository._criar();

  static Future<ConfiguracoesRepository> carregar() async {
    if (Hive.isBoxOpen(_chave)) {
      _box = Hive.box(_chave);
    } else {
      _box = await Hive.openBox(_chave);
    }
    return ConfiguracoesRepository._criar();
  }

  salvar(ConfiguracoesModel configuracoesModel) {
    _box.put(_chave, configuracoesModel);
  }

  ConfiguracoesModel obterDados() {
    var dados = _box.get(_chave);
    if (dados == null) {
      return ConfiguracoesModel.vazio();
    }
    return dados;
  }
}
