import 'package:flutter/material.dart';
import 'colors.dart';

const bold = FontWeight.bold;
const normal = FontWeight.normal;

ourStyle({weight = FontWeight.bold, double? size = 14, color = whiteColor}) {
  return TextStyle(fontSize: size, color: color, fontWeight: weight);
}
