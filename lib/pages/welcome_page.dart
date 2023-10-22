import 'package:desafio_calculadora_imc_hive/model/configuracoes_model.dart';
import 'package:desafio_calculadora_imc_hive/pages/main_page.dart';
import 'package:desafio_calculadora_imc_hive/repositories/configuracoes_repository.dart';
import 'package:desafio_calculadora_imc_hive/shared/widgets/app_images.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late ConfiguracoesRepository configuracoes;
  var configuracoesModel = ConfiguracoesModel.vazio();
  bool showMainPage = false;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    configuracoes = await ConfiguracoesRepository.carregar();
    configuracoesModel = configuracoes.obterDados();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 248, 192),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  Expanded(
                    flex: 20,
                    child: Image.asset(AppImages.imc),
                  ),
                  Expanded(child: Container()),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    "Calculadora de IMC - com dados armazenados localmente usando Hive",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                    value: showMainPage,
                    title: const Text(
                      "Mostrar página inicial ao entrar no app?",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        showMainPage = value!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 52, 0, 61))),
                  onPressed: () {
                    if (configuracoesModel.showMainPage != showMainPage) {
                      configuracoes.salvar(configuracoesModel);
                    }
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainPage(),
                        ));
                  },
                  child: const Text("Começar",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
