import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_app/global_provider.dart';
import 'package:weather_app/home/controller/call_weather_api.dart';
import 'package:weather_app/home/model/WeatherAPIResponse.dart';
import 'package:translator/translator.dart';

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
  final translator = GoogleTranslator();
  String translatedCityName = '';

  void callApi() {
    futureCityInfo = callWeatherApi(widget.city);
  }

  TextEditingController editCityController = TextEditingController();

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
              return buildErrorContainer(context);
            } else if (snapshot.hasData) {
              snapshot.data!.name!;
              return GestureDetector(
                onLongPress: () => showOptionsMenu(context),
                child: buildWeatherInfoContainer(snapshot),
              );
            } else {
              return const Center(child: Text('No user data'));
            }
          },
        ),
      ),
    );
  }

  Widget buildWeatherInfoContainer(AsyncSnapshot<WeatherApiResponse> snapshot) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            translatedCityName.isEmpty
                ? snapshot.data!.name!
                : translatedCityName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Weather - ${snapshot.data!.weather![0].description!}',
            textAlign: TextAlign.center,
          ),
          Image.network(
            'https://openweathermap.org/img/wn/${snapshot.data!.weather![0].icon}@2x.png',
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget buildErrorContainer(BuildContext context) {
    return GestureDetector(
      onLongPress: () => showOptionsMenu(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          border: Border.all(),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text('City name doesn\'t exist - ${widget.city}'),
      ),
    );
  }

  void showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Center(
                child: Text(
                  'Popup Menu',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ListTile(
                shape: Border.all(color: Colors.grey.shade300),
                title: const Text('Update'),
                onTap: () {
                  Navigator.pop(context);
                  showUpdateCityDialog(context);
                },
              ),
              const SizedBox(
                height: 12,
              ),
              ListTile(
                shape: Border.all(color: Colors.grey.shade300),
                title: const Text('Delete'),
                onTap: () {
                  GlobalSharables.cities.removeAt(widget.index);
                  ref.read(refresh.notifier).state = ref.read(refresh) + 1;
                  Fluttertoast.showToast(msg: 'City removed!');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showUpdateCityDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 250,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Update',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    controller: editCityController,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () {
                      setState(() {
                        GlobalSharables.cities[widget.index] =
                            editCityController.text;
                      });

                      Navigator.pop(context);
                      Fluttertoast.showToast(
                        msg: 'City updated!',
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
        );
      },
    );
  }
}
