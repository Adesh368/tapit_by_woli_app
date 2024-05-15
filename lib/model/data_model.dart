import 'package:flutter/material.dart';

class DataModel {
  const DataModel({
    this.id,
    this.name,
    this.color,
    this.price,
    this.telcoprice,
  });
  final String? id;
  final String? name;
  final Color? color;
  final int? price;
  final int? telcoprice;
}
