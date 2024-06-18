import 'package:flutter/material.dart';
import 'package:usando_api/model/cidade.dart';
import 'package:usando_api/services/cidade_service.dart';

class FormCidadePage extends StatefulWidget {
  final Cidade? cidade;

  const FormCidadePage({this.cidade});

  @override
  State<StatefulWidget> createState() => _FormCidadePageState();
}

class _FormCidadePageState extends State<FormCidadePage> {
  final _service = CidadeService();
  var _saving = false;
  final _formkey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  String? _currentUf;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _criarAppBar(),
      body: Container(),
    );
  }

  AppBar _criarAppBar() {
    final String title;
    if (widget.cidade == null) {
      title = 'Nova Cidade';
    } else {
      title = 'Alterar Cidade';
    }
    final Widget titleWidget;
    if (_saving) {
      titleWidget = Row(
        children: [
          Expanded(
            child: Text(title),
          ),
          const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
        ],
      );
    } else {
      titleWidget = Text(title);
    }
    return AppBar(
      title: titleWidget,
      actions: [
        if (_saving) ...[
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _save,
          )
        ]
      ],
    );
  }

//Implementar o List de UF

  Future<void> _save() async {
    if (_formkey.currentState == null || !_formkey.currentState!.validate()) {
      return;
    }
    setState(() {
      _saving = true;
    });
    try {
      await _service.saveCidade(Cidade(
          codigo: widget.cidade?.codigo,
          nome: _nomeController.text,
          uf: _currentUf!));
      Navigator.pop(context, true);
      return;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Não foi possível salvar a cidade, tente novamente'),
      ));
    }
    setState(() {
      _saving = false;
    });
  }
}
