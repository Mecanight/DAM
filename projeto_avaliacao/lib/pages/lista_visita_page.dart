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

@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: _criarAppBar(context),
    body: _criarBody(),
  )
}

AppBar _criarAppBar(BuildContext context){
  return AppBar(backgroundColor: Theme.of(context).colorScheme.primary,
  title: Text('Viagens'),
  centerTitle: true,
  actions: [
    IconButton(onPressed: null, icon: const Icon(Icons.map),
    )
  ],
  )
}
Widget _criarBody(){
  if (_viagens.isEmpty){
    child: Text("Você ainda não tem viagens")
  }
}
}


