import 'package:flutter_riverpod/flutter_riverpod.dart';

final banglaLanguage = StateProvider<bool>((ref) => false);
final refresh = StateProvider<int>((ref) => 0);
