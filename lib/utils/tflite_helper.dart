import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:io';

class TfliteHelper {
  static Interpreter? _interpreter;

  static Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/models/dr_model.tflite');
      print("✅ মডেল লোড হয়েছে!");
    } catch (e) {
      print("❌ মডেল লোড ফাইল: $e");
    }
  }

  static Future<String> runModel(String imagePath) async {
    if (_interpreter == null) await loadModel();

    // ছবি প্রিপ্রসেসিং (এখানে সিম্পল রাখলাম)
    File imgFile = File(imagePath);
    List<int> input = await imgFile.readAsBytes();

    // ইনপুট/আউটপুট শেপ
    var inputShape = _interpreter!.getInputTensor(0).shape;
    var outputShape = _interpreter!.getOutputTensor(0).shape;

    // মডেল রান
    var output = List<double>.filled(outputShape[1], 0.0);
    _interpreter!.run(input, output);

    // ফলাফল প্রসেস
    double confidence = output[1]; // 0 = Normal, 1 = DR
    if (confidence > 0.7) {
      return "আপনার চোখে ডায়াবেটিসের লক্ষণ আছে। ডাক্তার দেখান।";
    } else {
      return "আপনার চোখ স্বাভাবিক আছে।";
    }
  }
}
