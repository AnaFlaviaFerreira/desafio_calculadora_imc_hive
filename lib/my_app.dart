import 'package:desafio_calculadora_imc_hive/model/configuracoes_model.dart';
import 'package:desafio_calculadora_imc_hive/pages/main_page.dart';
import 'package:desafio_calculadora_imc_hive/pages/welcome_page.dart';
import 'package:desafio_calculadora_imc_hive/repositories/configuracoes_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ConfiguracoesRepository configuracoes;
  var configuracoesModel = ConfiguracoesModel.vazio();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    await Future.delayed(const Duration(seconds: 2));
    configuracoes = await ConfiguracoesRepository.carregar();
    configuracoesModel = configuracoes.obterDados();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textTheme: GoogleFonts.robotoSlabTextTheme(),
      ),
      home: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : !configuracoesModel.showMainPage! ||
                  configuracoesModel.showMainPage == null
              ? const WelcomePage()
              : const MainPage(),
    );
  }
}
