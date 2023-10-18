

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

class PdfApplication extends StatefulWidget {
  const PdfApplication({super.key});

  @override
  State<PdfApplication> createState() => _PdfApplicationState();
}

class _PdfApplicationState extends State<PdfApplication> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("PDF Picker and Viewer"),
        ),
        body: PDFViewerWidget(),
      ),
    );
  }
}

class PDFViewerWidget extends StatefulWidget {
  @override
  _PDFViewerWidgetState createState() => _PDFViewerWidgetState();
}

class _PDFViewerWidgetState extends State<PDFViewerWidget> {
  String? _filePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: pickPDFFile,
          child: Text("Pick a PDF File"),
        ),
        if (_filePath != null) pdfViewer(_filePath),
      ],
    );
  }

  Future<void> pickPDFFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      String? filePath = result.files.single.path;
      openPDF(filePath);
    }
  }

  Widget pdfViewer(String? filePath) {
    return Expanded(
      child: PDFView(
        filePath: filePath,
      ),
    );
  }

  void openPDF(String? filePath) {
    setState(() {
      _filePath = filePath;
      print("File path");
      print(_filePath);
      getPath(_filePath!);
    });
  }
  void getPath(String filepath) async
  {
    try {
      Uint8List pdfBytes = await convertFilePathToUint8List(filepath);
      print(pdfBytes);
      // Now you have the PDF content in Uint8List format
      // You can use pdfBytes as needed, such as sending it over the network or saving it to a file.
    } catch (e) {
      print("My Error : $e");
    }
  }
  Future<Uint8List> convertFilePathToUint8List(String? filePath) async {
    if (filePath == null) {
      throw Exception("File path is null.");
    }

    final file = File(filePath);

    if (!file.existsSync()) {
      throw Exception("File does not exist.");
    }

    // Read the PDF file as bytes
    final List<int> bytes = await file.readAsBytes();

    // Convert the bytes to a Uint8List
    final Uint8List uint8list = Uint8List.fromList(bytes);

    return uint8list;
  }
}









