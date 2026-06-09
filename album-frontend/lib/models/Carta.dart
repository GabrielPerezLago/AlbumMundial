import 'package:flutter/material.dart';

class Carta {
  int? id;
  String? nombre;
  DateTime? nacimiento;
  double? peso;
  double? altura;
  String? equipo;
  int? cantidad;

  Carta({
    this.id,
    this.nombre,
    this.nacimiento,
    this.peso,
    this.altura,
    this.equipo,
    this.cantidad,
  });

  factory Carta.fromJson(Map<String, dynamic> json) => Carta(
    id: json['id'],
    nombre: json['nombre'],
    nacimiento: DateTime.parse(json['nacimiento']),
    peso: json['peso'],
    altura: json['altura'],
    equipo: json['equipo'],
    cantidad: json['cantidad'] ?? null
  );

  List<dynamic> getElemsToList() {
    return [
      id,
      nombre,
      nacimiento,
      peso,
      altura,
      equipo,
      cantidad
    ];

  }

}