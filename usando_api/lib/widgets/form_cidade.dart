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
    if (widget.cidade != null) {
      _nomeController.text = widget.cidade!.nome;
      _currentUf = widget.cidade!.uf;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _criarAppBar(),
      body: _criarBody(),
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
          ),
        ],
      );
    } else {
      titleWidget = Text(title);
    }
    return AppBar(
      title: titleWidget,
      actions: [
        if (!_saving)
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _save,
          ),
      ],
    );
  }

  Widget _criarBody() => Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.cidade?.codigo != null)
                  Text('Código: ${widget.cidade!.codigo}'),
                TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                    ),
                    controller: _nomeController,
                    validator: (String? newValue) {
                      if (newValue == null || newValue.trim().isEmpty) {
                        return 'Informe o nome';
                      }
                      return null;
                    }),
                DropdownButtonFormField(
                    value: _currentUf,
                    decoration: const InputDecoration(
                      labelText: 'UF',
                    ),
                    items: _buildDropDownItens(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _currentUf = newValue;
                      });
                    },
                    validator: (String? newValue) {
                      if (newValue == null || newValue.trim().isEmpty) {
                        return 'Selecione a UF';
                      }
                      return null;
                    }),
              ],
            ),
          ),
        ),
      );

  List<DropdownMenuItem<String>> _buildDropDownItens() {
    const ufs = [
      'AC',
      'AL',
      'AP',
      'AM',
      'BA',
      'CE',
      'DF',
      'ES',
      'GO',
      'MA',
      'MT',
      'MS',
      'MG',
      'PA',
      'PB',
      'PR',
      'PE',
      'PI',
      'RJ',
      'RN',
      'RS',
      'RO',
      'RR',
      'SC',
      'SP',
      'SE',
      'TO'
    ];
    final List<DropdownMenuItem<String>> itens = [];
    for (final uf in ufs) {
      itens.add(
        DropdownMenuItem(value: uf, child: Text(uf)),
      );
    }
    return itens;
  }

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
        uf: _currentUf!,
      ));
      Navigator.pop(context, true);
      return;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Não foi possível salvar a cidade. Tente novamente.'),
      ));
    }
    setState(() {
      _saving = false;
    });
  }
}
