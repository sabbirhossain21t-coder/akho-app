import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:akho/utils/tflite_helper.dart';
import 'package:akho/utils/tts_helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String result = "";
  bool loading = false;

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        loading = true;
      });

      // AI মডেল রান করো
      String output = await TfliteHelper.runModel(image.path);
      setState(() {
        result = output;
        loading = false;
      });

      // বাংলা ভয়েস আউটপুট
      TtsHelper.speak(output);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("আখো — চোখের AI ডাক্তার")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: pickImage,
              child: Text("চোখের ছবি তুলুন"),
            ),
            SizedBox(height: 20),
            loading ? CircularProgressIndicator() : Text(result),
          ],
        ),
      ),
    );
  }
}
