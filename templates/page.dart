import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class {{FEATURE_PASCAL}}Page extends StatelessWidget {
  const {{FEATURE_PASCAL}}Page({super.key});
  
  static BeamPage beamLocation = BeamPage(
    child: const {{FEATURE_PASCAL}}Page(),
    key: const ValueKey('{{FEATURE_NAME}}'),
  );

  static const path = '/{{FEATURE_NAME}}';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('{{FEATURE_PASCAL}}'),
      ),
      body: const Center(
        child: Text('{{FEATURE_PASCAL}} Page'),
      ),
    );
  }
}
