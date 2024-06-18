import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:usando_api/pages/cidades_fragment.dart';
import 'package:usando_api/pages/consulta_cep_fragment.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _fragment = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _fragment == 0 ? ConsultaCepFragment.title : CidadesFragment.title),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _fragment,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: ConsultaCepFragment.title,
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

  Widget _buildBody() =>
      _fragment == 0 ? ConsultaCepFragment() : CidadesFragment();

  Widget? _buildFloatingActionButton() {
    if (_fragment == 0) {
      return null;
    }
    return FloatingActionButton(
      onPressed: null,
      child: Icon(Icons.add),
      tooltip: 'Cadastrar Cidade',
    );
  }
}
