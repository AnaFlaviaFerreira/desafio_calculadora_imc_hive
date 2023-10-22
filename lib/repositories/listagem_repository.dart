import 'package:desafio_calculadora_imc_hive/model/listagem_model.dart';
import 'package:hive/hive.dart';

class ListagemRepository {
  static late Box _box;
  static String _chave = "listagem";

  ListagemRepository._criar();

  static Future<ListagemRepository> carregar() async {
    if (Hive.isBoxOpen(_chave)) {
      _box = Hive.box(_chave);
    } else {
      _box = await Hive.openBox(_chave);
    }
    return ListagemRepository._criar();
  }

  salvar(ListagemModel listagemModel) {
    _box.add(listagemModel);
  }

  alterar(ListagemModel listagemModel) {
    listagemModel.save();
  }

  deletar(ListagemModel listagemModel) {
    listagemModel.delete();
  }

  List<ListagemModel> obterDados() {
    return _box.values.cast<ListagemModel>().toList();
  }
}
