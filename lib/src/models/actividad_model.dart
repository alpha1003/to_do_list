import 'dart:convert';

List<ActividadModel> ActividadModelFromJson(String str) => List<ActividadModel>.from(json.decode(str).map((x) => ActividadModel.fromJson(x)));

String ActividadModelToJson(List<ActividadModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ActividadModel {
    ActividadModel({
        this.id,
        required this.titulo,
        required this.descripcion,
        required this.activa,
    });

    int? id;
    String titulo;
    String descripcion;
    int activa;

    factory ActividadModel.fromJson(Map<String, dynamic> json) => ActividadModel(
        id: json["id"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        activa: json["activa"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "descripcion": descripcion,
        "activa": activa,
    }; 

    
}
