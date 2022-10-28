class Mensajes {
  int? id;
  String? login;
  String? titulo;
  String? texto;
  String? fecha;

  Mensajes({this.id, this.login, this.titulo, this.texto, this.fecha});

  Mensajes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    titulo = json['titulo'];
    texto = json['texto'];
    fecha = json['fecha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['titulo'] = this.titulo;
    data['texto'] = this.texto;
    data['fecha'] = this.fecha;
    return data;
  }
}
