import 'dart:ui';

import 'package:flutter/material.dart';

class Habit {
  const Habit({
    required this.title,
    required this.description,
    required this.startDate,
    required this.color,
    required this.icon,
  });

  final String title;
  final String description;
  final DateTime startDate;
  final Color color;
  final IconData icon;
}
