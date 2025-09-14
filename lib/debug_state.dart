import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:myapp/image_state.dart';
import 'package:flutter/widgets.dart';

class DebugState {
  static const _fileName = 'debug_state.json';

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_fileName');
  }

  static Future<void> saveState(List<ImageState> images) async {
    if (kDebugMode) {
      try {
        final file = await _localFile;
        final jsonList = images
            .map(
              (image) => {
                'id': image.id,
                'assetPath': image.assetPath,
                'matrix': image.matrix.storage.toList(),
                'size': image.size,
                'number': image.number,
                'name': image.name,
                'level': image.sign.level,
                'static': image.sign.static,
              },
            )
            .toList();
        await file.writeAsString(jsonEncode(jsonList));
      } catch (e) {
        // ignore: avoid_print
        print('Error saving debug state: $e');
      }
    }
  }

  static Future<List<ImageState>?> loadState() async {
    if (kDebugMode) {
      try {
        final file = await _localFile;
        if (await file.exists()) {
          final contents = await file.readAsString();
          final List<dynamic> jsonList = jsonDecode(contents);
          return jsonList.map((json) {
            return ImageState(
              id: json['id'],
              sign: SignInfo(
                assetPath: json['assetPath'],
                number: json['number'],
                name: json['name'],
                level: json['level'],
                static: json['static'],
              ),
              matrix: Matrix4.fromList(List<double>.from(json['matrix'])),
              size: json['size'],
            );
          }).toList();
        }
      } catch (e) {
        // ignore: avoid_print
        print('Error loading debug state: $e');
      }
    }
    return null;
  }
}
