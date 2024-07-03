import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global_provider.dart';

class ZaynaxLogo extends ConsumerWidget {
  final double size;
  const ZaynaxLogo({super.key, required this.size});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isBangla = ref.watch(banglaLanguage);
    return Image.asset(
      isBangla ? 'assets/logobn.png' : 'assets/logo.png',
      width: size,
    );
  }
}
