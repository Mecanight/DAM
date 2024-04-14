import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projeto_avaliacao/model/viagem.dart';

class ListaViagemPage extends StatefulWidget {
  @override
  ListaViagemPageState createState() => _ListaViagemPageState();
}

class _ListaViagemPageState extends State<_ListaViagemPageState>{
final _viagens = <Viagem>;
var _ultimoId = 0;

static const ACAO_EDITAR = 'editar';
static const ACAO_EXCLUIR = 'excluir';

void initstate(){

}

@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: _criarAppBar(context),
    body: _criarBody(),
    floatingActionButton: FloatingActionButton(
      onPressed: _abrirForm,
      child: Icon(Icons.add
      ),
      ),
  );
}

AppBar _criarAppBar(BuildContext context){
  return AppBar(backgroundColor: Theme.of(context).colorScheme.primaryContainer,
  title: Text('Viagens'),
  centerTitle: true,
  actions: [
    IconButton(onPressed: _abrirFiltro, icon: const Icon(Icons.map),
    )
  ],
  )
}
Widget _criarBody(){
  if (_viagens.isEmpty){
    return const Center(
    child: Text("Você ainda não tem viagens",
    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
    );
  }

  return ListView.separated(
    itemBuilder: (BuildContext context, int index) {
      final viagem = _viagem[index];
      return PopupMenuButton<String>(
        child: ListTile(
          title: Text('${viagem.id}'),)
        itemBuilder: itemBuilder)
    }
  ),
}
}


