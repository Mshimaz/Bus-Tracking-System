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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text('Scan Ticket'),
      ),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Container(
                height: 300, width: 300, child: CameraPreview(controller))),
        SizedBox(
          height: 50,
        ),
        MaterialButton(
          color: Color(0xff4480F4),
          onPressed: () {
            _takePicture();
          },
          child: const Text(
            'Scan Ticket',
            style: TextStyle(color: Colors.white),
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
      print(allText);
      List<String> lines = allText.split("\n");
      List<String> route = [];

      final busNo =
          lines.firstWhere((line) => line.startsWith('KL'), orElse: () => '');
      for (var line in lines) {
        if (line.contains('TO')) {
          route.add(line);
        }
      }

      //String busNo = lines[2];
      print(busNo);
      busNumber = busNo;
      textDetector.close();
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return ShowBusNumberScreen(busNumber: "$busNo \n $route");
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
