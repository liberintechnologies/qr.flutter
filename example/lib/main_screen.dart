/*
 * QR.Flutter
 * Copyright (c) 2019 the QR.Flutter authors.
 * See LICENSE for distribution and usage details.
 */

import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// This is the screen that you'll see when the app starts
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  QrDataModuleShape dataShape = QrDataModuleShape.square;
  QrEyeShape eyeShape = QrEyeShape.square;

  @override
  Widget build(BuildContext context) {
    final message =
        // ignore: lines_longer_than_80_chars
        'Hey this is a QR code. Change this value in the main_screen.dart file.';

    final qrFutureBuilder = FutureBuilder<ui.Image>(
      future: _loadOverlayImage(),
      builder: (ctx, snapshot) {
        final size = 280.0;
        if (!snapshot.hasData) {
          return Container(width: size, height: size);
        }
        return CustomPaint(
          size: Size.square(size),
          painter: QrPainter(
            data: message,
            version: QrVersions.auto,
            eyeStyle: QrEyeStyle(
              eyeShape: eyeShape,
              color: Color(0xff128760),
            ),
            dataModuleStyle: QrDataModuleStyle(
              dataModuleShape: dataShape,
              color: Colors.brown,
            ),
            // size: 320.0,
            embeddedImage: snapshot.data,
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size.square(60),
            ),
          ),
        );
      },
    );

    return Material(
      color: Colors.white,
      child: SafeArea(
        top: true,
        bottom: true,
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Container(
                    width: 280,
                    child: qrFutureBuilder,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40)
                      .copyWith(bottom: 40),
                  child: Column(
                    children: [
                      //for eye pattern
                      Container(
                        height: 35,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                             Center(child: Text('Eye Pattern')),
                             SizedBox(width: 10,),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  eyeShape = QrEyeShape.circle;
                                });
                              },
                              child: Container(
                                color: Colors.blue,
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Circle"),
                                )),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  eyeShape = QrEyeShape.roundedOuterSquare;
                                });
                              },
                              child: Container(
                                color: Colors.blue,
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Outer Rounded"),
                                )),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  eyeShape = QrEyeShape.square;
                                });
                              },
                              child: Container(
                                color: Colors.blue,
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Reset"),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //for data patterns
                      Container(
                        height: 35,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                              Center(child: Text('Data Pattern')),
                             SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  dataShape = QrDataModuleShape.circle;
                                });
                              },
                              child: Container(
                                color: Colors.blue,
                                child: Center(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Circle"),
                                )),
                              ),
                            ),
                             SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  dataShape = QrDataModuleShape.randomCircle;
                                });
                              },
                              child: Container(
                                color: Colors.blue,
                                child: Center(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Random circle"),
                                )),
                              ),
                            ),
                             SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  dataShape = QrDataModuleShape.diamond;
                                });
                              },
                              child: Container(
                                color: Colors.blue,
                                child: Center(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Diamond"),
                                )),
                              ),
                            ),
                             SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  dataShape = QrDataModuleShape.square;
                                });
                              },
                              child: Container(
                                color: Colors.blue,
                                child: Center(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Square"),
                                )),
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<ui.Image> _loadOverlayImage() async {
    final completer = Completer<ui.Image>();
    final byteData = await rootBundle.load('assets/images/4.0x/logo_yakka.png');
    ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
    return completer.future;
  }
}
