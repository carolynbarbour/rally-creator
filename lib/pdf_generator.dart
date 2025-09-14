import 'dart:typed_data';
import 'dart:math' as math;

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:myapp/image_state.dart';
import 'package:flutter/material.dart';

Future<void> generateAndPrintPdf(
  List<ImageState> placedImages,
  Size dimensions,
  String title,
) async {
  final pdf = pw.Document();

  final List<ImageState> numberedSigns = placedImages.where((image) {
    final lowercasedAssetPath = image.assetPath.toLowerCase();
    return !lowercasedAssetPath.contains('bonus') &&
        !lowercasedAssetPath.contains('base');
  }).toList();

  final imageBytes = <String, Uint8List>{};
  for (final image in placedImages) {
    final byteData = await rootBundle.load(image.assetPath);
    imageBytes[image.assetPath] = byteData.buffer.asUint8List();
  }

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        const pageFormat = PdfPageFormat.a4;
        final pageHeight = pageFormat.availableHeight;
        final pageWidth = pageFormat.availableWidth;

        // The grid widget on the screen has a certain size. The image matrices are relative to that.
        // Let's find the bounding box of all images to determine the extent of the content.
        double minX = double.infinity,
            minY = double.infinity,
            maxX = double.negativeInfinity,
            maxY = double.negativeInfinity;

        if (placedImages.isEmpty) {
          minX = 0;
          minY = 0;
          maxX = dimensions.width * 50;
          maxY = dimensions.height * 50;
        } else {
          for (final image in placedImages) {
            final translation = image.matrix.getTranslation();
            final size = image.size;
            if (translation.x < minX) minX = translation.x;
            if (translation.y < minY) minY = translation.y;
            if (translation.x + size > maxX) maxX = translation.x + size;
            if (translation.y + size > maxY) maxY = translation.y + size;
          }
        }

        final contentWidth = maxX - minX;
        final contentHeight = maxY - minY;

        // Leave space for title and list
        final titleHeight = 40.0;
        final listEstimatedHeight = placedImages.length * 15.0;
        final availableHeightForGrid =
            pageHeight - titleHeight - listEstimatedHeight;

        final contentWidthWithPadding = contentWidth + 40; // for side numbers
        final contentHeightWithPadding = contentHeight + 20; // for top numbers

        final scaleX = pageWidth / contentWidthWithPadding;
        final scaleY = availableHeightForGrid / contentHeightWithPadding;
        final scale = scaleX < scaleY ? scaleX : scaleY;

        final scaledCellWidth = (contentWidth / dimensions.width) * scale;
        final scaledCellHeight = (contentHeight / dimensions.height) * scale;

        return [
          pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
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
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  // Left numbers
                  pw.Column(
                    children: [
                      pw.SizedBox(height: 20), // Spacer for top numbers
                      ...List.generate(
                        dimensions.height.toInt(),
                        (index) => pw.Container(
                          height: scaledCellHeight,
                          width: 20,
                          alignment: pw.Alignment.centerRight,
                          padding: const pw.EdgeInsets.only(right: 4),
                          child: pw.Text(
                            '${index + 1}',
                            style: const pw.TextStyle(fontSize: 7),
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.Column(
                    children: [
                      // Top numbers
                      pw.Row(
                        children: List.generate(
                          dimensions.width.toInt(),
                          (index) => pw.Container(
                            width: scaledCellWidth,
                            height: 20,
                            alignment: pw.Alignment.center,
                            child: pw.Text(
                              '${index + 1}',
                              style: const pw.TextStyle(fontSize: 7),
                            ),
                          ),
                        ),
                      ),
                      pw.Container(
                        width: contentWidth * scale,
                        height: contentHeight * scale,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(color: PdfColors.grey),
                        ),
                        child: pw.Stack(
                          children: [
                            // Signs
                            ...placedImages.map((image) {
                              final lowercasedAssetPath = image.assetPath
                                  .toLowerCase();
                              final bool isSpecialSign =
                                  lowercasedAssetPath.contains('start') ||
                                  lowercasedAssetPath.contains('finish') ||
                                  lowercasedAssetPath.contains('bonus') ||
                                  lowercasedAssetPath.contains('base');

                              int displayIndex = -1;
                              if (!isSpecialSign) {
                                displayIndex = numberedSigns.indexOf(image);
                              }

                              final translation = image.matrix.getTranslation();
                              final angle = math.atan2(
                                image.matrix.storage[1],
                                image.matrix.storage[0],
                              );

                              return pw.Positioned(
                                left: (translation.x - minX) * scale,
                                top: (translation.y - minY) * scale,
                                child: pw.Transform.rotate(
                                  angle: angle,
                                  child: pw.Stack(
                                    children: [
                                      pw.Container(
                                        width: image.size * scale,
                                        height: image.size * scale,
                                        child: pw.Image(
                                          pw.MemoryImage(
                                            imageBytes[image.assetPath]!,
                                          ),
                                        ),
                                      ),
                                      if (!isSpecialSign && displayIndex != -1)
                                        pw.Positioned(
                                          top: 0,
                                          right: 0,
                                          child: pw.Container(
                                            padding: const pw.EdgeInsets.all(
                                              1.5,
                                            ),
                                            color: PdfColors.yellow,
                                            child: pw.Text(
                                              '${displayIndex + 1}',
                                              style: pw.TextStyle(
                                                color: PdfColors.black,
                                                fontSize: 6 * scale,
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Right numbers
                  pw.Column(
                    children: [
                      pw.SizedBox(height: 20), // Spacer for top numbers
                      ...List.generate(
                        dimensions.height.toInt(),
                        (index) => pw.Container(
                          height: scaledCellHeight,
                          width: 20,
                          alignment: pw.Alignment.centerLeft,
                          padding: const pw.EdgeInsets.only(left: 4),
                          child: pw.Text(
                            '${index + 1}',
                            style: const pw.TextStyle(fontSize: 7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Divider(),
              pw.SizedBox(height: 10),
              // Signs List
              pw.ListView.builder(
                itemCount: placedImages.length,
                itemBuilder: (context, index) {
                  final image = placedImages[index];
                  final count = placedImages
                      .take(index + 1)
                      .where((img) => img.isCounted)
                      .length;
                  return pw.Container(
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
                        pw.Text(
                          image.name,
                          style: const pw.TextStyle(fontSize: 8),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ];
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
