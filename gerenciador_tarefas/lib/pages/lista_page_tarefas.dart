import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas/model/tarefa.dart';
import 'package:gerenciador_tarefas/widgets/conteudo_form_dialog.dart';

class ListaTarefaPage extends StatefulWidget {
  @override
  _ListaTarefaPageState createState() => _ListaTarefaPageState();
}

class _ListaTarefaPageState extends State<ListaTarefaPage> {
  final _tarefas = <Tarefa>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _criarAppBar(context),
      body: _criarBody(),
      floatingActionButton: FloatingActionButton(
          onPressed: _abrirForm,
          child: Icon(Icons.add),
          tooltip: 'Nova Tarefa'),
    );
  }

  AppBar _criarAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text('Tarefas'),
        centerTitle: false,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.filter_list))]);
  }

  Widget _criarBody() {
    if (_tarefas.isEmpty) {
      return const Center(
        child: Text(
          'Tudo certo por aqui!!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    }
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          final tarefa = _tarefas[index];
          return ListTile(
            title: Text('${tarefa.id} - ${tarefa.descricao}'),
            subtitle: Text('Prazo - ${tarefa.prazoFormatado}'),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: _tarefas.length);
  }

  void _abrirForm({Tarefa? tarefaAtual, int? indice}) {
    final key = GlobalKey<ConteudoFormDialogState>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(tarefaAtual == null
                ? 'Nova tarefa'
                : 'Aterar Tarefa ${tarefaAtual.id}'),
            content: ConteudoFormDialog(key: key, tarefaAtual: tarefaAtual),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancelar')),
              TextButton(onPressed: () {}, child: Text('Salvar'))
            ],
          );
        });
  }
}
