import 'package:flutter/material.dart';
import 'package:gerenciador_tarefas/pages/filtro_pages.dart';
import 'package:gerenciador_tarefas/pages/lista_page_tarefas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gerenciador Tarefas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        primaryColor: Colors.lightBlue,
        useMaterial3: true,
      ),
      home: ListaTarefaPage(),
      routes: {
        FiltroPage.ROUTE_NAME: (BuildContext context) => FiltroPage(),
      },
    );
  }
}
