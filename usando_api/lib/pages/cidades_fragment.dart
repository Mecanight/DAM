import 'package:flutter/material.dart';
import 'package:usando_api/model/cidade.dart';
import 'package:usando_api/services/cidade_service.dart';
import 'package:usando_api/widgets/form_cidade.dart';

class CidadesFragment extends StatefulWidget {
  static const title = 'Cidades';

  const CidadesFragment({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CidadesFragmentState();
}

class CidadesFragmentState extends State<CidadesFragment> {
  final _service = CidadeService();
  final List<Cidade> _cidades = [];
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: LayoutBuilder(
        builder: (_, constraints) {
          Widget content;
          if (_cidades.isEmpty) {
            content = SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: const Center(
                  child: Text('Nenhuma cidade cadastrada'),
                ),
              ),
            );
          } else {
            content = ListView.separated(
              itemCount: _cidades.length,
              itemBuilder: (_, index) {
                final cidade = _cidades[index];
                return ListTile(
                  title: Text('${cidade.nome} - ${cidade.uf}'),
                  onTap: () => _mostrarDialogActions(cidade),
                );
              },
              separatorBuilder: (_, __) => const Divider(),
            );
          }
          return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _findCidades,
            child: content,
          );
        },
      ),
    );
  }

  Future<void> _findCidades() async {
    await Future.delayed(const Duration(seconds: 2));
    final cidades = await _service.findCidade();
    setState(() {
      _cidades.clear();
      if (cidades.isNotEmpty) {
        _cidades.addAll(cidades);
      }
    });
  }

  void _mostrarDialogActions(Cidade cidade) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('${cidade.nome} - ${cidade.uf}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Editar'),
                onTap: () {
                  Navigator.pop(context);
                  abrirForm(cidade: cidade);
                }),
            const Divider(),
            ListTile(
                leading: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                title: const Text('Excluir'),
                onTap: () {
                  Navigator.pop(context);
                  _excluir(cidade);
                }),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  void abrirForm({Cidade? cidade}) {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (_) => FormCidadePage(cidade: cidade),
    ))
        .then((changed) {
      if (changed == true) {
        _refreshIndicatorKey.currentState?.show();
      }
    });
  }

  void _excluir(Cidade cidade) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Atenção'),
        content: Text('O registro "${cidade.nome} = ${cidade.uf}" '
            'será removido definitivamente'),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                _service.deleteCidade(cidade).then((_) {
                  _refreshIndicatorKey.currentState?.show();
                }).catchError((error, stackTrace) {
                  print(stackTrace ?? error);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        'Não foi possível remover a cidade. Tente novamente.'),
                  ));
                });
              }),
        ],
      ),
    );
  }
}
