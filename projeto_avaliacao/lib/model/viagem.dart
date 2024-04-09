import 'dart:html';

class Viagem {
  static const p_id = "_id";
  static const p_local = "local";
  static const p_descicao = "comentario";

  int id;
  String local;
  String comentario;

  Viagem({required this.id, required this.local, required this.comentario});

  String get localFormatado {
    return local; //Geolocation(Geolocation).format(local);
  }
}
