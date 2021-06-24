
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mnistdigitrecognizer/models/prediction.dart';
import 'package:mnistdigitrecognizer/screens/drawing_painter.dart';
import 'package:mnistdigitrecognizer/screens/prediction_widget.dart';
import 'package:mnistdigitrecognizer/services/recognizer.dart';
import 'package:mnistdigitrecognizer/utils/constants.dart';

class DrawScreen extends StatefulWidget {
  @override
  _DrawScreenState createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> {
  final _points = List<Offset>();
  final _recognizer = Recognizer();
  List<Prediction> _prediction;
  bool initialize = false;

  @override
  void initState() {
    super.initState();
    _initModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digit Recognizer'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'MNIST database of handwritten digits',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'The digits have been size-normalized and centered in a fixed-size images (28 x 28)',
                      )
                    ],
                  ),
                ),
              ),
              _mnistPreviewImage(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          _drawCanvasWidget(),
          SizedBox(
            height: 10,
          ),
          PredictionWidget(
            predictions: _prediction,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.clear),
        onPressed: () {
          setState(() {
            _points.clear();
            _prediction.clear();
          });
        },
      ),
    );
  }

  Widget _drawCanvasWidget() {
    return Container(
      width: Constants.canvasSize + Constants.borderSize * 2,
      height: Constants.canvasSize + Constants.borderSize * 2,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: Constants.borderSize,
        ),
      ),
      child: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          Offset _localPosition = details.localPosition;
          if (_localPosition.dx >= 0 &&
              _localPosition.dx <= Constants.canvasSize &&
              _localPosition.dy >= 0 &&
              _localPosition.dy <= Constants.canvasSize) {
            setState(() {
              _points.add(_localPosition);
            });
          }