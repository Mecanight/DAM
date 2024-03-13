import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas/model/tarefa.dart';
import 'package:intl/intl.dart';

class ConteudoFormDialog extends StatefulWidget {
  final Tarefa? tarefaAtual;

  ConteudoFormDialog({Key? key, this.tarefaAtual}) : super(key: key);

  @override
  ConteudoFormDialogState createState() => ConteudoFormDialogState();
}

class ConteudoFormDialogState extends State<ConteudoFormDialog> {
  final formKey = GlobalKey<FormState>();
  final descricaoController = TextEditingController();
  final prazoController = TextEditingController();
  final _prazoFormatado = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    if (widget.tarefaAtual != null) {
      descricaoController.text = widget.tarefaAtual!.descricao;
      prazoController.text = widget.tarefaAtual!.prazoFormatado;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
              controller: descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
              validator: (String? valor) {
                if (valor == null || valor.isEmpty) {
                  return 'Informe a descrição!';
                }
                return null;
              }),
          TextFormField(
            controller: prazoController,
            decoration: InputDecoration(
                labelText: 'Prazo',
                prefixIcon: IconButton(
                  onPressed: _mostraCalendario,
                  icon: Icon(Icons.calendar_today),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => prazoController.clear(),
                )),
            readOnly: true,
          )
        ],
      ),
    );
  }

  void _mostraCalendario() {
    final dataFormatada = prazoController.text;
    var data = DateTime.now();

    if (dataFormatada.isNotEmpty) {
      data = _prazoFormatado.parse(dataFormatada);
    }
    showDatePicker(
      context: context,
      initialDate: data,
      firstDate: data.subtract(Duration(days: 1825)),
      lastDate: data.add(Duration(days: 1825)),
    );
  }
}
