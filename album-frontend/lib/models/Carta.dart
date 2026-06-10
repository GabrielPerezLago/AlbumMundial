import 'package:flutter/material.dart';

class Carta {
  int? id;
  String? nombre;
  DateTime? nacimiento;
  double? peso;
  double? altura;
  String? equipo;
  int? cantidad;
  bool? tiene;

  Carta({
    this.id,
    this.nombre,
    this.nacimiento,
    this.peso,
    this.altura,
    this.equipo,
    this.cantidad,
    this.tiene,
  });

  factory Carta.fromJson(Map<String, dynamic> json) => Carta(
    id: json['id'],
    nombre: json['nombre'],
    nacimiento: DateTime.parse(json['nacimiento']),
    peso: json['peso'],
    altura: json['altura'],
    equipo: json['equipo'],
    cantidad: json['cantidad'] ?? null,
    tiene: json['tieneCarta'] ?? null
  );

  factory Carta.fromJsonToCuantity(Map<String, dynamic> json, int cuantity) => Carta(
      id: json['id'],
      nombre: json['nombre'],
      nacimiento: DateTime.parse(json['nacimiento']),
      peso: json['peso'],
      altura: json['altura'],
      equipo: json['equipo'],
      cantidad: json['cantidad'] ?? cuantity
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