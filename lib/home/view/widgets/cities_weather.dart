import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_app/global_provider.dart';
import 'package:weather_app/home/controller/call_weather_api.dart';
import 'package:weather_app/home/model/WeatherAPIResponse.dart';

class CitiesWeatherWidget extends ConsumerStatefulWidget {
  const CitiesWeatherWidget(
      {super.key, required this.city, required this.index});
  final String city;
  final int index;

  @override
  CitiesWeatherWidgetState createState() => CitiesWeatherWidgetState();
}

class CitiesWeatherWidgetState extends ConsumerState<CitiesWeatherWidget> {
  late Future<WeatherApiResponse> futureCityInfo;

  void callApi() {
    futureCityInfo = callWeatherApi(widget.city);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(refresh);
    callApi();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Center(
        child: FutureBuilder<WeatherApiResponse>(
          future: futureCityInfo,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(16)),
                  child: Text('City name doesnt exist - ${widget.city}'));
            } else if (snapshot.hasData) {
              return GestureDetector(
                onLongPress: () {
                  GlobalSharables.cities.removeAt(widget.index);
                  ref.read(refresh.notifier).state = ref.read(refresh) + 1;
                  Fluttertoast.showToast(msg: 'City removed!');
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(snapshot.data!.name!),
                      Text(snapshot.data!.weather![0].description!),
                      Image.network(
                          'https://openweathermap.org/img/wn/${snapshot.data!.weather![0].icon}@2x.png')
                    ],
                  ),
                ),
              );
            } else {
              return Text('No user data');
            }
          },
        ),
      ),
    );
  }
}
