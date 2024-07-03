import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_app/global_provider.dart';

class DrawerOtherDetails extends ConsumerStatefulWidget {
  const DrawerOtherDetails({super.key});

  @override
  DrawerOtherDetailsState createState() => DrawerOtherDetailsState();
}

class DrawerOtherDetailsState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    bool isBn = ref.watch(banglaLanguage);

    final WidgetStateProperty<Color?> trackColor =
        WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) {
        // Track color when the switch is selected.
        if (states.contains(WidgetState.selected)) {
          return const Color(0xffFD0164);
        }
        // Otherwise return null to set default track color
        // for remaining states such as when the switch is
        // hovered, focused, or disabled.
        return null;
      },
    );
    final WidgetStateProperty<Color?> overlayColor =
        WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) {
        // Material color when switch is selected.
        if (states.contains(WidgetState.selected)) {
          return const Color(0xffFD0164).withOpacity(0.54);
        }
        // Material color when switch is disabled.
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey.shade400;
        }
        // Otherwise return null to set default material color
        // for remaining states such as when the switch is
        // hovered, or focused.
        return null;
      },
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.language),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(isBn ? 'ভাষা' : 'Language')
                ],
              ),
              Switch(
                value: isBn,
                overlayColor: overlayColor,
                trackColor: trackColor,
                thumbColor: const WidgetStatePropertyAll<Color>(Colors.white),
                onChanged: (bool value) {
                  Fluttertoast.showToast(
                    msg:
                        'This language change is only limited to this drawer and the logo in home page.',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  setState(() {
                    isBn = value;
                    ref.read(banglaLanguage.notifier).state = value;
                  });
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
