import 'package:flutter_riverpod/flutter_riverpod.dart';

final banglaLanguage = StateProvider<bool>((ref) => false);
final refresh = StateProvider<int>((ref) => 0);

class GlobalSharables {
  static List cities = ['Dhaka', 'Khulna', 'Mumbai', 'London', 'Tottenham'];
}
