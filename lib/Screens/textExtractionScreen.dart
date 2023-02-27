import 'package:flutter/material.dart';
import 'dart:io';
import 'package:camera/camera.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';

class TicketExtractionScreen extends StatefulWidget {
  const TicketExtractionScreen({super.key});

  @override
  State<TicketExtractionScreen> createState() => _TicketExtractionScreenState();
}

class _TicketExtractionScreenState extends State<TicketExtractionScreen> {
  late List<CameraDescription> cameras;
  late CameraController controller;

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    await controller.initialize();
    setState(() {});
  }

  Future<void> _takePicture() async {
    try {
      final image = await controller.takePicture();
      // final FirebaseVisionImage visionImage =
      //     FirebaseVisionImage.fromFile(File(image.path));
      // final TextRecognizer textRecognizer =
      //     FirebaseVision.instance.textRecognizer();
      // final VisionText visionText =
      //     await textRecognizer.processImage(visionImage);
      // String recognizedText = visionText.text;
      //print(recognizedText);
      // textRecognizer.close();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _initializeCamera();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: CameraPreview(controller),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: _takePicture,
              child: Text('Take Picture'),
            ),
          ),
        ],
      ),
    );
  }
}
