import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moreRotations = ref.watch(moreRotationsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          CheckboxListTile(
            title: const Text('Include more rotations (in 45 degree elements)'),
            value: moreRotations,
            onChanged: (bool? value) {
              ref.read(moreRotationsProvider.notifier).update(value ?? false);
            },
          ),
        ],
      ),
    );
  }
}
