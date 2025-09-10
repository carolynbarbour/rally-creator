import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/providers.dart';

class InputScreen extends StatelessWidget {
  InputScreen({super.key});

  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grid Dimensions')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _widthController,
              decoration: const InputDecoration(labelText: 'Width (10-20)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _heightController,
              decoration: const InputDecoration(labelText: 'Height (10-20)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 32),
            Consumer(
              builder: (context, ref, child) {
                return ElevatedButton(
                  onPressed: () {
                    final int width = int.tryParse(_widthController.text) ?? 0;
                    final int height =
                        int.tryParse(_heightController.text) ?? 0;

                    if (width >= 10 &&
                        width <= 20 &&
                        height >= 10 &&
                        height <= 20) {
                      ref
                          .read(gridDimensionsProvider.notifier)
                          .setDimensions(
                            Size(width.toDouble(), height.toDouble()),
                          );
                      context.go('/grid');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please enter values between 10 and 20.',
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Continue'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
