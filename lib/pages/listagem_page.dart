import 'package:desafio_calculadora_imc_hive/model/configuracoes_model.dart';
import 'package:desafio_calculadora_imc_hive/model/listagem_model.dart';
import 'package:desafio_calculadora_imc_hive/repositories/classificacao_repository.dart';
import 'package:desafio_calculadora_imc_hive/repositories/configuracoes_repository.dart';
import 'package:desafio_calculadora_imc_hive/repositories/listagem_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListagemPage extends StatefulWidget {
  const ListagemPage({super.key});

  @override
  State<ListagemPage> createState() => _ListagemPageState();
}

class _ListagemPageState extends State<ListagemPage> {
  late ConfiguracoesRepository configuracoes;
  late ListagemRepository listagemRepository;
  var configuracoesModel = ConfiguracoesModel();
  var _listagem = <ListagemModel>[];
  bool loading = true;
  TextEditingController pesoController = TextEditingController();
  var classificacoes = [];
  var classificacaoRepository = ClassificacaoRepository();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    await Future.delayed(const Duration(seconds: 2));
    configuracoes = await ConfiguracoesRepository.carregar();
    configuracoesModel = configuracoes.obterDados();
    listagemRepository = await ListagemRepository.carregar();
    _listagem = listagemRepository.obterDados();
    classificacoes = classificacaoRepository.retornaListaClassificacao();
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
            "Listagem",
            style: GoogleFonts.nosifer(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              builder: (context) => Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Wrap(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Text(
                        "Adicione o peso:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: pesoController,
                        decoration: const InputDecoration(hintText: "Peso"),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: TextButton(
                            onPressed: () async {
                              setState(() {
                                loading = false;
                              });
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (configuracoesModel.altura! <= 0) {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text(
                                      "Adicionar dados",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: const Text(
                                        "Favor informar dados na aba configurações primeiro antes de adicionar o peso!"),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("ok"))
                                    ],
                                  ),
                                );
                                return;
                              }

                              double peso = 0;
                              try {
                                peso = double.parse(pesoController.text);
                              } catch (e) {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text("Adicionar peso"),
                                    content: const Text(
                                        "Favor informar uma peso válida!"),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("ok"))
                                    ],
                                  ),
                                );
                                return;
                              }

                              double imc = peso /
                                  (configuracoesModel.altura! *
                                      configuracoesModel.altura!);
                              await listagemRepository.salvar(
                                  ListagemModel.criar(peso,
                                      double.parse(imc.toStringAsFixed(2))));
                              Navigator.pop(context);
                              setState(() {
                                loading = true;
                              });
                              carregarDados();
                            },
                            child: const Text(
                              "Salvar",
                              style: TextStyle(fontSize: 20),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
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
              : configuracoesModel.altura! <= 0
                  ? const Center(
                      child: Text(
                        "Adicione as suas informações na aba configurações primeiro.",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  : Column(
                      children: [
                        if (configuracoesModel.altura != null &&
                            configuracoesModel.altura != 0)
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 3, vertical: 8),
                            child: Text(
                              "Sua altura: ${configuracoesModel.altura!.toStringAsFixed(2)}",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        Expanded(
                            child: ListView.builder(
                          itemCount: _listagem.length,
                          itemBuilder: (context, index) {
                            var lista = _listagem[index];
                            String classificacao = "";

                            if (lista.imc! < 16) {
                              classificacao = classificacoes[0];
                            } else if (lista.imc! >= 16 && lista.imc! < 17) {
                              classificacao = classificacoes[1];
                            } else if (lista.imc! >= 17 && lista.imc! < 18.5) {
                              classificacao = classificacoes[2];
                            } else if (lista.imc! >= 18.5 && lista.imc! < 25) {
                              classificacao = classificacoes[3];
                            } else if (lista.imc! >= 25 && lista.imc! < 30) {
                              classificacao = classificacoes[4];
                            } else if (lista.imc! >= 30 && lista.imc! < 35) {
                              classificacao = classificacoes[5];
                            } else if (lista.imc! >= 35 && lista.imc! < 40) {
                              classificacao = classificacoes[6];
                            } else {
                              classificacao = classificacoes[7];
                            }

                            return Dismissible(
                              key: Key(lista.imc.toString()),
                              onDismissed: (direction) async {
                                await listagemRepository.deletar(lista);
                                carregarDados();
                              },
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                color: Colors.red,
                                child: const Icon(Icons.delete,
                                    color: Colors.white),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ListTile(
                                      title: const Text("Peso",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700)),
                                      subtitle: Text(lista.peso.toString()),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: ListTile(
                                      title: const Text("IMC",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700)),
                                      subtitle: Text(lista.imc.toString()),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: ListTile(
                                      title: const Text("Classificacao",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700)),
                                      subtitle: Text(classificacao),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ))
                      ],
                    ),
        ),
      ),
    );
  }
}
