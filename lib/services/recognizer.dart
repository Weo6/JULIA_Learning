import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mnistdigitrecognizer/utils/constants.dart';
import 'package:tflite/tflite.dart';

final _canvasCullRect = Rect.fromPoints(
  Off