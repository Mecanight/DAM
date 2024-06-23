import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usando_api_md/pages/cidades_fragment.dart';
import 'package:usando_api_md/pages/consulta_cep_fragmet.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _listaCidadesKey = GlobalKey<CidadesFragmentState>();
  var _fragment = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _fragment == 0 ? ConsultaCepFragmet.title : CidadesFragment.title),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _fragment,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: ConsultaCepFragmet.title,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: CidadesFragment.title,
          )
        ],
        onTap: (int newIndex) {
          if (newIndex != _fragment) {
            setState(() {
              _fragment = newIndex;
            });
          }
        },
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildBody() => _fragment == 0
      ? ConsultaCepFragmet()
      : CidadesFragment(key: _listaCidadesKey);

  Widget? _buildFloatingActionButton() {
    if (_fragment == 0) {
      return null;
    }
    return FloatingActionButton(
      child: const Icon(Icons.add),
      tooltip: 'Cadastrar Cidade',
      onPressed: () => _listaCidadesKey.currentState?.abrirForm(),
    );
  }
}
