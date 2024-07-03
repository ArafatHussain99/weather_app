import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_app/global_provider.dart';
import 'package:weather_app/home/view/widgets/cities_weather.dart';
import 'package:weather_app/home/view/widgets/drawer_other_details.dart';
import 'package:weather_app/home/view/widgets/drawer_profile_info.dart';
import 'package:weather_app/home/view/widgets/zaynax_logo.dart';
import 'package:weather_app/notifications/view/notification_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState {
  List cities = ['Dhaka', 'Khulna', 'Mumbai', 'London', 'Tottenham'];
  TextEditingController newCity = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, NotificationScreen.id);
                },
                child: const Icon(Icons.notifications_outlined)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ZaynaxLogo(
                size: MediaQuery.of(context).size.height / 5,
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled:
                        true, // Make the bottom sheet scrollable
                    builder: (BuildContext context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: SingleChildScrollView(
                          child: SizedBox(
                            height: 200,
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Text('Add a new city'),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    TextField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                      controller: newCity,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    ElevatedButton(
                                      child: const Text('Submit'),
                                      onPressed: () {
                                        setState(() {
                                          cities.add(newCity.text);
                                        });

                                        Navigator.pop(context);
                                        Fluttertoast.showToast(
                                          msg: 'New city added!',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.black54,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(child: Text('Add new city')),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height / 5 -
                    16 -
                    46,
                child: RefreshIndicator(
                  onRefresh: () async {
                    ref.read(refresh.notifier).state = ref.read(refresh) + 1;
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cities.length,
                    itemBuilder: (context, index) {
                      return CitiesWeatherWidget(city: cities[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: const Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            DrawerProfileInfo(),
            SizedBox(
              height: 12,
            ),
            DrawerOtherDetails(),
          ],
        ),
      ),
    );
  }
}
