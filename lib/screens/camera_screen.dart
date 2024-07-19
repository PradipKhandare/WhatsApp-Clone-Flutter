import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_node_express_mongo/screens/video_view.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'camera_view.dart';
import 'package:image_picker/image_picker.dart';

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key, this.onImageSend});

  final Function(String)? onImageSend;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> cameraValue;
  bool _isTakingPicture = false; // Flag to track if a picture is being taken
  File? _selectedImage;
  bool isRecoring = false;
  bool flash = false;
  bool isCameraFront = true;
  double transform = 0;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(
                  _cameraController,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              flash = !flash;
                            });

                            flash
                                ? _cameraController
                                .setFlashMode(FlashMode.torch)
                                : _cameraController.setFlashMode(FlashMode.off);
                          },
                          icon: flash
                              ? const Icon(
                            Icons.flash_on,
                            color: Colors.white,
                            size: 28,
                          )
                              : const Icon(
                            Icons.flash_off,
                            color: Colors.white,
                            size: 28,
                          )),
                      GestureDetector(
                        onLongPress: () async {
                          await _cameraController.startVideoRecording();
                          setState(() {
                            isRecoring = true;
                          });
                        },
                        onLongPressUp: () async {
                          XFile videopath =
                          await _cameraController.stopVideoRecording();
                          setState(() {
                            isRecoring = false;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => VideoView(
                                path: videopath.path,
                              ),
                            ),
                          );
                        },
                        onTap: () {
                          if (!isRecoring) takePhoto(context);
                        },
                        child: isRecoring
                            ? const Icon(
                          Icons.radio_button_on,
                          color: Colors.red,
                          size: 80,
                        )
                            : const Icon(
                          Icons.panorama_fish_eye,
                          color: Colors.white,
                          size: 70,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          setState(() {
                            isCameraFront = !isCameraFront;
                            transform = transform + pi;
                          });
                          int cameraPos = isCameraFront ? 0 : 1;
                          _cameraController = CameraController(
                              cameras[cameraPos], ResolutionPreset.high);
                          cameraValue = _cameraController.initialize();
                        },
                        icon: Transform.rotate(
                          angle: transform,
                          child: const Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    "hold for video, tap for photo",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    if (_isTakingPicture) return;
    setState(() {
      _isTakingPicture = true;
    });

    try {
      final XFile picture = await _cameraController.takePicture();
      // Check if onImageSend is not null before calling it
      if (widget.onImageSend != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => CameraViewPage(
              path: picture.path,
              onImageSend: widget.onImageSend!,
            ),
          ),
        );
      } else {
        print("onImageSend is null");
      }
    } catch (e) {
      // Handle any errors here
      print(e);
    } finally {
      setState(() {
        _isTakingPicture = false;
      });
    }
  }
}
