import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:mywaether/constants.dart';

import 'package:mywaether/controller/weather_states.dart';
import 'package:mywaether/methods.dart';
import 'package:mywaether/models/cache_helper.dart';
import 'package:mywaether/models/weather_model.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  WeatherCubit() : super(WeatherInitial());
  static WeatherCubit get(context) => BlocProvider.of(context);
  static const String apiKey = 'bfc289704104498fbc6105444230409';
  static const String baseUrl = 'http://api.weatherapi.com/v1/forecast.json?';
  WeatherModel? weatherModel;
  //method to  get weather data by using city name or location
  getWeather({String? cityName, double? lat, double? long}) async {
    emit(GetWeatherLoadingState());
    //full url
    String url;
    //url by using city name
    if (cityName != null) {
      url = '${baseUrl}key=$apiKey&q=$cityName&days=1&aqi=no&alerts=no';
    }
    //url by using location
    else if (long != null && lat != null) {
      url = '${baseUrl}key=$apiKey&q=$lat,$long&days=1&aqi=no&alerts=no';
    } else {
      print('***need permossion');
      emit(GetWeatherFailureState());
      return;
    }
    try {
      http.Response response = await http.get(Uri.parse(url));
      //when success get
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        weatherModel = WeatherModel.fromJson(data);
        //save city name to later
        await CacheHelper.setData(
            key: kCityName, value: weatherModel!.cityName);

        emit(GetWeatherSuccessState());
      } else {
        print('error in status code: ${response.statusCode}');
        emit(GetWeatherFailureState());
      }
    } catch (e) {
      print('**** ${e.toString()}');
      emit(GetWeatherFailureState());
    }
  }

//method to handle location permission
  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //when service isn't enabled
    if (!serviceEnabled) {
      buildShowDialog(context,
          title: 'Location Permissions',
          content: 'Location services are disabled. Please enable the services',
          settings: () {
        Navigator.pop(context);
        Geolocator.openLocationSettings();
      });

      return false;
    }
    //check permission
    permission = await Geolocator.checkPermission();
    //when permission is denied
    if (permission == LocationPermission.denied) {
      //request permission
      permission = await Geolocator.requestPermission();
      //when still denied show dialog
      if (permission == LocationPermission.denied) {
        buildShowDialog(context,
            title: 'Location Permissions',
            content: 'Location permissions are denied', settings: () {
          Navigator.pop(context);
          Geolocator.openAppSettings();
        });

        return false;
      }
    }
    //when permission is denied forever, show dialog
    if (permission == LocationPermission.deniedForever) {
      buildShowDialog(context,
          title: 'Location Permissions',
          content:
              'Location permissions are permanently denied, we cannot request permissions.',
          settings: () {
        Navigator.pop(context);
        Geolocator.openAppSettings();
      });

      return false;
    }
    //we check all option so the permission is allowed
    return true;
  }

  Position? _currentPosition;
  double? lat;
  double? long;
//function to get the current location
  Future<void> getCurrentPosition(BuildContext context) async {
    try {
      //boolean variable to sure that permission is enabled but come in future
      final hasPermission = await _handleLocationPermission(context);
      emit(GetLocationLoadingState());
      //the permission is denied, so returen without do anything
      if (!hasPermission) return;
      //here that mean that the permission is allowed, so get the current location
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        _currentPosition = position;
        lat = position.latitude;
        long = position.longitude;

        emit(GetLocationSuccessState());
      }).catchError((e) {
        print(e.toString());
        emit(GetWeatherFailureState());
      });
    } catch (e) {
      emit(GetWeatherFailureState());
    }
  }

  List<String> cities = ['mecca', 'cairo'];
  List<WeatherModel> citiesModel = [];

//function to get popular cities weather
  getPopularCities() {
    cities.forEach((element) async {
      String request =
          '${baseUrl}key=$apiKey&q=$element&days=1&aqi=no&alerts=no';
      http.Response response = await http.get(Uri.parse(request));
      Map<String, dynamic> data = jsonDecode(response.body);
      WeatherModel weatherModel = WeatherModel.fromJson(data);
      citiesModel.add(weatherModel);
    });
    emit(GetCitiesSuccessState());
  }
}
