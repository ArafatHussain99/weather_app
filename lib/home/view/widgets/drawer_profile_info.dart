import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/global_provider.dart';
import 'package:weather_app/profile/view/profile_screen.dart';

class DrawerProfileInfo extends ConsumerWidget {
  const DrawerProfileInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isBan = ref.watch(banglaLanguage);
    return SafeArea(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(offset: Offset(0, 0.5))],
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.orangeAccent,
                    child: Icon(Icons.male),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(isBan ? 'আরাফাত' : 'Arafat'),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, ProfileScreen.id);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(offset: Offset(0, 0.5))
                              ],
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            isBan ? 'প্রোফাইল পরিচালনা করুন' : 'Manage Profile',
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
