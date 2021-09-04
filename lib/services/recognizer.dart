import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mnistdigitrecognizer/utils/constants.dart';
import 'package:tflite/tflite.dart';

final _canvasCullRect = Rect.fromPoints(
  Offset(0, 0),
  Offset(Constants.imageSize, Constants.imageSize),
);

final _whitePaint = Paint()
  ..strokeCap = StrokeCap.round
  ..color = Colors.white
  ..strokeWidth = Constants.strokeWidth;

final _bgPaint = Paint()
  ..color = Colors.black;

class Recognizer {
  Future loadModel() {
    Tflite.close();

    return Tflite.loadModel(
      model: "assets/mnist.tflite",
      labels: