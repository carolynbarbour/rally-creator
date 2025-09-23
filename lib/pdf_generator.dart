import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:myapp/image_state.dart';
import 'package:screenshot/screenshot.dart';
import 'package:myapp/widgets/printable_grid.dart';

Future<void> generateAndPrintPdf(
  List<ImageState> placedImages,
  Size dimensions,
  String title,
  ScreenshotController screenshotController,
  double gridHeight,
  double cellDimension,
) async {
  final pdf = pw.Document();

  const double targetWidth = 1200;
  final double targetHeight =
      targetWidth * (PdfPageFormat.a4.height / PdfPageFormat.a4.width);

  final image = await screenshotController.captureFromWidget(
    Container(
      width: targetWidth,
      height: targetHeight,
      color: Colors.white,
      child: Material(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: PrintableGrid(
            dimensions: dimensions,
            gridHeight: gridHeight,
            cellDimension: cellDimension,
            placedImages: placedImages,
          ),
        ),
      ),
    ),
    pixelRatio: 1.5,
    targetSize: Size(targetWidth, targetHeight),
  );

  // Page 1: Title and Grid
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Container(
              padding: const pw.EdgeInsets.only(bottom: 10),
              alignment: pw.Alignment.center,
              child: pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Expanded(
              child: pw.FittedBox(child: pw.Image(pw.MemoryImage(image))),
            ),
          ],
        );
      },
    ),
  );

  // Page 2: Signs List
  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        int count = 0;
        return [
          pw.Text(
            'Signs:',
            style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 10),
          pw.Divider(),
          pw.SizedBox(height: 10),
          ...placedImages
              .where(
                (element) =>
                    element.name.isNotEmpty &&
                    !(element.assetPath.toLowerCase().contains('base') &&
                        !(element.name.contains('Start') ||
                            element.name.contains('Finish') ||
                            element.name.contains('Bonus'))),
              )
              .map((imageState) {
                if (imageState.isCounted) {
                  count++;
                }
                return pw.Container(
                  padding: const pw.EdgeInsets.symmetric(vertical: 1.5),
                  child: pw.Row(
                    children: [
                      pw.Container(
                        width: 20,
                        child: pw.Text(
                          imageState.isCounted ? '$count' : ' ',
                          style: const pw.TextStyle(fontSize: 8),
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Expanded(
                        child: pw.Text(
                          imageState.name,
                          style: const pw.TextStyle(fontSize: 8),
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Text(
                        imageState.number.isEmpty
                            ? ''
                            : '#${imageState.number}',
                        style: const pw.TextStyle(fontSize: 8),
                      ),
                    ],
                  ),
                );
              }),
        ];
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
