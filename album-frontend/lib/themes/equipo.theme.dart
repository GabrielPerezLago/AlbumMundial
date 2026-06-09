import 'package:flutter/material.dart';

Color? ThemeEquipoColor(String equipo) => _ThemeEquipo[equipo];

Map<String, Color> _ThemeEquipo = {
  'espana': Colors.red,
  'brasil': Colors.green
};