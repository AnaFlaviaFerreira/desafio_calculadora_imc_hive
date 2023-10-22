import 'package:desafio_calculadora_imc_hive/model/configuracoes_model.dart';
import 'package:desafio_calculadora_imc_hive/repositories/configuracoes_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  late ConfiguracoesRepository configuracoes;
  var configuracoesModel = ConfiguracoesModel();
  TextEditingController nomeController = TextEditingController();

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
    nomeController.text = configuracoesModel.nome ?? "";
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Configurações",
            style: GoogleFonts.nosifer(),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: loading
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LinearProgressIndicator(),
                  ],
                )
              : ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const Text(
                          "Nome:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: nomeController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Altura: ${configuracoesModel.altura ?? 0}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Slider(
                      min: 0,
                      max: 5.00,
                      value: configuracoesModel.altura ?? 0,
                      onChanged: (value) {
                        String altura = value.toStringAsFixed(2);
                        setState(() {
                          configuracoesModel.altura = double.parse(altura);
                        });
                      },
                    ),
                    SwitchListTile(
                      title: const Text("Mostrar tela inicial"),
                      value: configuracoesModel.showMainPage ?? false,
                      onChanged: (value) {
                        setState(() {
                          configuracoesModel.showMainPage = value;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const Text(
                          "Gênero:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () => setState(() {
                            configuracoesModel.genero = "F";
                          }),
                          child: Card(
                            color: configuracoesModel.genero == "F"
                                ? Colors.purple
                                : Colors.grey.shade300,
                            elevation: 8,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.female,
                                    size: 50,
                                    color: configuracoesModel.genero == "F"
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  Text(
                                    "Femino",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: configuracoesModel.genero == "F"
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () => setState(() {
                            configuracoesModel.genero = "M";
                          }),
                          child: Card(
                            color: configuracoesModel.genero == "M"
                                ? Colors.purple
                                : Colors.grey.shade300,
                            elevation: 8,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.male,
                                    size: 50,
                                    color: configuracoesModel.genero == "M"
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  Text(
                                    "Masculino",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: configuracoesModel.genero == "M"
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: TextButton(
                          onPressed: () async {
                            setState(() {
                              loading = false;
                            });
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (nomeController.text.isEmpty ||
                                nomeController.text.trim() == "") {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text("Configurações"),
                                  content: const Text(
                                      "Favor informar um nome válido!"),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("ok"))
                                  ],
                                ),
                              );
                              return;
                            } else if (configuracoesModel.altura! <= 0) {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text("Configurações"),
                                  content: const Text(
                                      "Favor informar uma altura válida!"),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("ok"))
                                  ],
                                ),
                              );
                              return;
                            } else if (configuracoesModel.genero!.isEmpty) {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text("Configurações"),
                                  content:
                                      const Text("Favor selecionar um gênero!"),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("ok"))
                                  ],
                                ),
                              );
                              return;
                            }
                            configuracoesModel.nome = nomeController.text;
                            configuracoes.salvar(configuracoesModel);
                            setState(() {
                              loading = true;
                            });
                            Future.delayed(
                              const Duration(seconds: 1),
                              () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Dados salvo com sucesso")));
                              },
                            );
                            carregarDados();
                          },
                          child: const Text(
                            "Salvar",
                            style: TextStyle(fontSize: 20),
                          )),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
