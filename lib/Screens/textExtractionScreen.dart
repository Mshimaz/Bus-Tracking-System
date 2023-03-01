import 'package:bus_track/Screens/showBusNoScreen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class TicketExtractionScreen extends StatefulWidget {
  const TicketExtractionScreen({super.key});

  @override
  State<TicketExtractionScreen> createState() => _TicketExtractionScreenState();
}

class _TicketExtractionScreenState extends State<TicketExtractionScreen> {
  late CameraController controller;
  late Future<void> _initializeControllerFuture;
  String busNumber = "";

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    await controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _buildCameraPreview();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildCameraPreview() {
    return Stack(
      children: [
        CameraPreview(controller),
        Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            onPressed: () {
              _takePicture();
            },
            child: const Text('Take Picture'),
          ),
        ),
      ],
    );
  }

  Future<void> _takePicture() async {
    try {
      final image = await controller.takePicture();
      final InputImage inputImage = InputImage.fromFilePath(image.path);
      final TextRecognizer textDetector = GoogleMlKit.vision.textRecognizer();
      final RecognizedText recognisedText =
          await textDetector.processImage(inputImage);
      String allText = recognisedText.text;
      List<String> lines = allText.split("\n");
      String busNo = lines[2];
      print(busNo);
      busNumber = busNo;
      textDetector.close();
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return ShowBusNumberScreen(busNumber: busNo);
      }));
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
