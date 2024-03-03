import 'package:flutter/material.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primaryColor: Colors.lightBlue,
        useMaterial3: true,
      ),
      home: ListaTarefaPage(),
    );
  }
}
