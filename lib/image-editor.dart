import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:ui' as ui;

import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';

class ImageEditor extends StatefulWidget {
  final File file;
  final String selectedConversation;

  const ImageEditor({Key key, this.file, this.selectedConversation})
      : super(key: key);

  @override
  _ImageEditorState createState() => _ImageEditorState();
}

class _ImageEditorState extends State<ImageEditor> with TickerProviderStateMixin {
  GlobalKey previewContainerKey = new GlobalKey();
  List<DrawingPoints> _points = <DrawingPoints>[];
  Image _editedImage;
  Paint myPaint;
  Color selectedColor = Colors.black;
  Color pickerColor = Colors.black;
  double strokeWidth = 3.0;
  bool showBottomList = false;
  double opacity = 1.0;
  StrokeCap strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round;
  SelectedMode selectedMode = SelectedMode.StrokeWidth;
  List<Color> colors = [Colors.red, Colors.green, Colors.blue, Colors.amber, Colors.black];
  final _boundaryKey = GlobalKey();
  String downloadUrl;


  File uploadFile;
  final List<IconData> icons = const [
    Icons.album,
    Icons.opacity,
    Icons.color_lens,
    Icons.undo,
    Icons.crop,
  ];
  AnimationController _controller;
  bool _showFileAttachmentMenu = false;
  TextEditingController _messageController;

  @override
  void initState() {
    _messageController = TextEditingController();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        key: previewContainerKey,
        body: RepaintBoundary(
          key: _boundaryKey,
          child: Stack(
            children: <Widget>[
              if (_editedImage == null) Image.file(widget.file),
              if (_editedImage != null) _editedImage,
              Positioned.fill(
                child: GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        RenderBox renderBox = context.findRenderObject();
                        _points.add(DrawingPoints(
                            points: renderBox.globalToLocal(details.globalPosition),
                            paint: Paint()
                              ..strokeCap = strokeCap
                              ..isAntiAlias = true
                              ..color = selectedColor.withOpacity(opacity)
                              ..strokeWidth = strokeWidth));
                      });
                    },
                    onPanStart: (details) {
                      setState(() {
                        RenderBox renderBox = context.findRenderObject();
                        _points.add(DrawingPoints(
                            points: renderBox.globalToLocal(details.globalPosition),
                            paint: Paint()
                              ..strokeCap = strokeCap
                              ..isAntiAlias = true
                              ..color = selectedColor.withOpacity(opacity)
                              ..strokeWidth = strokeWidth));
                      });
                    },
                    onPanEnd: (details) {
                      setState(() {
                        _points.add(null);
                      });
                    },
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: ImageEditorPainter(pointsList: _points),
                    )),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          height: 120,
          child: Column(children: <Widget>[
            Visibility(
              child: (selectedMode == SelectedMode.Color)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: getColorList(),
                    )
                  : Slider(
                      value: (selectedMode == SelectedMode.StrokeWidth) ? strokeWidth : opacity,
                      max: (selectedMode == SelectedMode.StrokeWidth) ? 50.0 : 1.0,
                      min: 0.0,
                      onChanged: (val) {
                        setState(() {
                          if (selectedMode == SelectedMode.StrokeWidth)
                            strokeWidth = val;
                          else
                            opacity = val;
                        });
                      }),
              visible: showBottomList,
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 8, left: 8),
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (BuildContext context, Widget child) {
                        return Transform(
                          transform: Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                          alignment: FractionalOffset.center,
                          child: IconButton(
                            constraints: BoxConstraints(
                              maxHeight: 50,
                              maxWidth: 50,
                            ),
                            icon: Icon(
                              _controller.isDismissed ? Icons.edit : Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () {
                              if (_controller.isDismissed) {
                                setState(() {
                                  _showFileAttachmentMenu = true;
                                });
                                _controller.forward();
                              } else {
                                setState(() {
                                  _showFileAttachmentMenu = false;
                                });
                                _controller.reverse();
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Stack(children: <Widget>[
                      if (!_showFileAttachmentMenu)
                        Material(
                          color: Colors.white10,
                          elevation: 5,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(maxHeight: 150),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    reverse: true,
                                    child: TextField(
                                      maxLines: null,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        hintText: 'type your message',
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15.0),
                                          ),
                                        ),
                                      ),
                                      controller: _messageController,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (_showFileAttachmentMenu)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: List.generate(
                            icons.length,
                            (index) => Container(
                              height: 70.0,
                              width: 56.0,
                              alignment: FractionalOffset.centerRight,
                              child: ScaleTransition(
                                scale: CurvedAnimation(
                                  parent: _controller,
                                  curve: Interval(0.0, 1.0 - index / icons.length / 2.0,
                                      curve: Curves.easeOut),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: FloatingActionButton(
                                    heroTag: null,
                                    mini: true,
                                    backgroundColor: Colors.white10,
                                    child: Icon(icons[index], color: Colors.blue),
                                    onPressed: () async {
                                      if (index == 0) {
                                        setState(() {
                                          if (selectedMode == SelectedMode.StrokeWidth)
                                            showBottomList = !showBottomList;
                                          selectedMode = SelectedMode.StrokeWidth;
                                        });
                                      } else if (index == 1) {
                                        setState(() {
                                          if (selectedMode == SelectedMode.Opacity)
                                            showBottomList = !showBottomList;
                                          selectedMode = SelectedMode.Opacity;
                                        });
                                      } else if (index == 2) {
                                        setState(() {
                                          if (selectedMode == SelectedMode.Color)
                                            showBottomList = !showBottomList;
                                          selectedMode = SelectedMode.Color;
                                        });
                                      } else if (index == 3) {
                                        setState(() {
                                          showBottomList = false;
                                          _points.clear();
                                        });
                                      } else if (index == 4) {
                                        File cropped = await ImageCropper.cropImage(
                                          sourcePath: widget.file.path,
                                        );
                                        setState(() {
                                          _editedImage = Image.file(cropped);
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 8, left: 8),
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                    child: IconButton(
                        constraints: BoxConstraints(
                          maxHeight: 50,
                          maxWidth: 50,
                        ),
                        icon: Icon(Icons.send, color: Colors.white, size: 20),
                        onPressed: () async {
                          File _file;
                          final pixelRatio = MediaQuery.of(context).devicePixelRatio;
                          final boundary = _boundaryKey.currentContext.findRenderObject()
                              as RenderRepaintBoundary;
                          final image = await boundary.toImage(pixelRatio: pixelRatio);
                          final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

                          Uint8List pngBytes = byteData.buffer.asUint8List();
                          setState(() {
                            _editedImage = Image.memory(pngBytes.buffer.asUint8List());
                          });
                          try {
                            _file = await writeToFile(byteData);
                          } catch (e) {}
                        }),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future<File> writeToFile(ByteData data) async {
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath + '/${DateTime.now()}.png';
    return new File(filePath)
        .writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  getColorList() {
    List<Widget> listWidget = List();
    for (Color color in colors) {
      listWidget.add(colorCircle(color));
    }
    Widget colorPicker = GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          child: AlertDialog(
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: pickerColor,
                onColorChanged: (color) {
                  pickerColor = color;
                },
                pickerAreaHeightPercent: 0.8,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('Save'),
                onPressed: () {
                  setState(() => selectedColor = pickerColor);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.only(bottom: 16.0),
          height: 36,
          width: 36,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.red, Colors.green, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
        ),
      ),
    );
    listWidget.add(colorPicker);
    return listWidget;
  }

  Widget colorCircle(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
          showBottomList = false;
        });
      },
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.only(bottom: 16.0),
          height: 36,
          width: 36,
          color: color,
        ),
      ),
    );
  }


}

class ImageEditorPainter extends CustomPainter {
  List<DrawingPoints> pointsList;

  ImageEditorPainter({this.pointsList});

  List<Offset> offsetPoints = List();

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        canvas.drawLine(pointsList[i].points, pointsList[i + 1].points, pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList[i].points);
        offsetPoints.add(Offset(pointsList[i].points.dx , pointsList[i].points.dy));
        canvas.drawPoints(PointMode.points, offsetPoints, pointsList[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(ImageEditorPainter oldDelegate) => true;
}

class DrawingPoints {
  Paint paint;
  Offset points;

  DrawingPoints({this.points, this.paint});
}

enum SelectedMode { StrokeWidth, Opacity, Color }
