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

  final image = await screenshotController.captureFromWidget(
    Material(
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
  );

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        final List<pw.Widget> content = [];

        // Title
        content.add(
          pw.Container(
            padding: const pw.EdgeInsets.only(bottom: 10),
            alignment: pw.Alignment.center,
            child: pw.Text(
              title,
              style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
            ),
          ),
        );

        // Grid Image
        content.add(pw.Image(pw.MemoryImage(image)));

        content.add(pw.SizedBox(height: 10));
        content.add(pw.Divider());
        content.add(pw.SizedBox(height: 10));

        // Signs List Header
        content.add(
          pw.Text(
            'Signs:',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
        );
        content.add(pw.SizedBox(height: 5));

        // Signs List
        int count = 0;
        for (final image in placedImages) {
          if (image.isCounted) {
            count++;
          }
          content.add(
            pw.Container(
              padding: const pw.EdgeInsets.symmetric(vertical: 1.5),
              child: pw.Row(
                children: [
                  pw.Container(
                    width: 20,
                    child: pw.Text(
                      image.isCounted ? '$count' : ' ',
                      style: const pw.TextStyle(fontSize: 8),
                    ),
                  ),
                  pw.SizedBox(width: 10),
                  pw.Expanded(
                    child: pw.Text(
                      image.name,
                      style: const pw.TextStyle(fontSize: 8),
                    ),
                  ),
                  pw.SizedBox(width: 10),
                  pw.Text(
                    image.number.isEmpty ? '' : '#${image.number}',
                    style: const pw.TextStyle(fontSize: 8),
                  ),
                ],
              ),
            ),
          );
        }

        return content;
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
