import 'dart:io';

import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import '../../../FileCRUD.dart';
import 'package:gozlukstore/models/Glass.dart';

List<CameraDescription> cameras;

// void main() async {
//     print("main");
//   runApp(CameraView());
// }

class CameraView extends StatefulWidget {
  const CameraView({
    Key key,
    @required this.modelFilePath,
  }) : super(key: key);
  // final Glass product;
  final String modelFilePath;

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  ArCoreFaceController arCoreFaceController;
  ArCoreController arCoreController;
  String objectSelected;
  int crownToShow;
  ByteData textureBytes;
  File imageFile;
  CameraController controller;
  Future<void> _initializeControllerFuture;
  bool isFace = false;

  @override
  void initState() {
    super.initState();

    print(widget.modelFilePath);
    objectSelected = widget.modelFilePath;
    if (isFace) {
      WidgetsFlutterBinding.ensureInitialized(); // main function
      initController();
      setState(() {
        controller = CameraController(cameras[1], ResolutionPreset.ultraHigh);
        _initializeControllerFuture = controller.initialize();
      });
    }
  }

  initController() async {
    cameras = await availableCameras(); // main function
    textureBytes = await rootBundle.load('assets/images/black.png');

    // await dowloadFileGetPath().then((value) {setState(() {filePath = value;});});
    if (!isFace) {
    } else {
      arCoreFaceController.loadMesh(
        textureBytes: textureBytes.buffer.asUint8List(),
        skin3DModelFilename: widget.modelFilePath,
      );
    }
  }

  // Future<String> dowloadFileGetPath() async {
  //   var instance = FileIO();
  //   var fileName = "${this.widget.product.title}.sfb";
  //   if(await instance.fileExist(fileName))
  //   {
  //      await getApplicationDocumentsDirectory().then((Directory directory) {
  //           return "${directory.path}/{fileName}";
  //     });
  //   }

  //   return await instance.downloadFile(this.widget.product.arSupported,'${this.widget.product.title}.sfb');
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: FutureBuilder(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (isFace) {
                    return Stack(
                      children: <Widget>[
                        ArCoreFaceView(
                          onArCoreViewCreated: _onArCoreViewCreated,
                          enableAugmentedFaces: true,
                        ),
                        //CameraPreview(controller),
                      ],
                    );
                  } else {
                    return MaterialApp(
                      home: Scaffold(
                        body: Stack(
                          children: <Widget>[
                            ArCoreView(
                              onArCoreViewCreated: _onArCoreViewCreate,
                              enableTapRecognizer: true,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })),
    );
  }

  void _onArCoreViewCreate(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => onTapHandler(name);
    arCoreController.onPlaneTap = _handleOnPlaneTap;
  }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    _addToucano(hit);
  }

  void _addToucano(ArCoreHitTestResult plane) {
    if (objectSelected != null) {
      //"https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF/Duck.gltf"
      final toucanoNode = ArCoreReferenceNode(
          name: objectSelected,
          object3DFileName: objectSelected,
          position: plane.pose.translation,
          rotation: plane.pose.rotation);

      arCoreController.addArCoreNodeWithAnchor(toucanoNode);
    } else {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(content: Text('Select an object!')),
      );
    }
  }

  void _onArCoreViewCreated(ArCoreFaceController controller) {
    arCoreFaceController = controller;
    loadMesh();
  }

  loadMesh() async {
    final ByteData textureBytes =
        await rootBundle.load('assets/images/black.png');

    arCoreFaceController.loadMesh(
      textureBytes: textureBytes.buffer.asUint8List(),
      skin3DModelFilename: widget.modelFilePath,
    );
  }

  void onTapHandler(String name) {
    print("Flutter: onNodeTap");
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Row(
          children: <Widget>[
            Text('Remove $name?'),
            IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                onPressed: () {
                  arCoreController.removeNode(nodeName: name);
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (!isFace) {
      arCoreController.dispose();
    } else {
      arCoreFaceController.dispose();
    }
    super.dispose();
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: FileImage(
                  File(imagePath),
                ),
                fit: BoxFit.cover)),
      ),
    );
  }
}
