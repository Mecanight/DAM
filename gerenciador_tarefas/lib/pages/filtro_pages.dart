import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas/model/tarefa.dart';

class FiltroPage extends StatefulWidget {
  static const ROUTE_NAME = '/filtro';
  static const CHAVE_CAMPO_ORDENACAO = 'campoOrdenacao';
  static const CHAVE_ORDENAR_DECRESCENTE = 'usarOrdemDecrescente';
  static const CHAVE_FILTRO_DERCRICAO = 'filtroDescricao';

  @override
  _FiltroPageState createState() => _FiltroPageState();
}

@override
class _FiltroPageState extends State<FiltroPage> {
  final camposParaOrdenacao = {
    Tarefa.campo_id: 'Código',
    Tarefa.campo_descricao: 'Descrição',
    Tarefa.campo_prazo: 'Prazo'
  };

  late final SharedPreferences prefs;
  final _descricaoControler = TextEditingController();
  String _campoOrdenacao = Tarefa.campo_id;
  bool _usarOrdamDecrescente = false;
  bool _alterouValores = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            title: Text('Filtro e Ordenação'),
          ),
          body: _criarBody(),
        ),
        onWillPop: null);
  }

  Widget _criarBody() {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Text('Campos para ordenação'),
        ),
        for (final campo in camposParaOrdenacao.keys)
          Row(
            children: [
              Radio(
                value: campo,
                groupValue: camposParaOrdenacao,
                onChanged: _onCampoOrdenacaoChanged,
              ),
              Text(camposParaOrdenacao[campo] ?? ''),
            ],
          ),
        Divider(),
        Row(
          children: [
            Checkbox(
              value: _usarOrdamDecrescente,
              onChanged: null,
            ),
            Text('Usar ordem decrescente')
          ],
        ),
        Divider(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            decoration: InputDecoration(labelText: 'a descrição começa com'),
          ),
        ),
      ],
    );
  }

  void _onCampoOrdenacaoChanged(String? valor) {
    prefs.setString(FiltroPage.CHAVE_CAMPO_ORDENACAO, valor ?? '');
    _alterouValores = true;
    setState(() {
      _campoOrdenacao = valor ?? '';
    });
  }
}
