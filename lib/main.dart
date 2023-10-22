import 'package:desafio_calculadora_imc_hive/model/configuracoes_model.dart';
import 'package:desafio_calculadora_imc_hive/model/listagem_model.dart';
import 'package:desafio_calculadora_imc_hive/my_app.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  //configurando o Hive
  WidgetsFlutterBinding.ensureInitialized();
  var documentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentDirectory.path);

  //adapters
  Hive.registerAdapter(ListagemModelAdapter());
  Hive.registerAdapter(ConfiguracoesModelAdapter());

  runApp(const MyApp());
}
