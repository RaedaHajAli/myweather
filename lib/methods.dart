import 'package:flutter/material.dart';
import 'package:mywaether/models/images_class.dart';

//function  to choose specific dynamic condition image

String? getImage(String weatherState) {
  String? image;
  if (weatherState.contains('sunny')) {
    image = ImagesModel.sunny;
  } else if (weatherState.contains('snow')) {
    image = ImagesModel.snowy;
  } else if (weatherState.contains('cloud') || weatherState == 'overcast') {
    image = ImagesModel.cloudy;
  } else if (weatherState.contains('mist') || weatherState.contains('fog')) {
    image = ImagesModel.mist;
  } else if (weatherState.contains('rain')) {
    image = ImagesModel.rainy;
  } else if (weatherState.contains('thunder')) {
    image = ImagesModel.thunderRain;
  } else if (weatherState.contains('clear')) {
    image = ImagesModel.clear;
  } else if (weatherState.contains('wind')) {
    image = ImagesModel.wind;
  } else {
    image = null;
  }
  return image;
}
//function to choose specific static condition image

String? getStaticImage(String weatherState) {
  String? image;
  if (weatherState.contains('sunny')) {
    image = ImagesModel.sunnyS;
  } else if (weatherState.contains('snow')) {
    image = ImagesModel.snowyS;
  } else if (weatherState.contains('cloud') || weatherState == 'overcast') {
    image = ImagesModel.cloudyS;
  } else if (weatherState.contains('mist') || weatherState.contains('fog')) {
    image = ImagesModel.mistS;
  } else if (weatherState.contains('rain')) {
    image = ImagesModel.rainyS;
  } else if (weatherState.contains('thunder')) {
    image = ImagesModel.thunderRain;
  } else if (weatherState.contains('clear')) {
    image = ImagesModel.clearS;
  } else if (weatherState.contains('wind')) {
    image = ImagesModel.windS;
  } else {
    image = null;
  }
  return image;
}

//function to build dialog
Future<dynamic> buildShowDialog(dynamic context,
    {required String title,
    required String content,
    void Function()? settings}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              onPressed: settings ?? () {},
              child: const Text('Settings'),
            ),
          ],
        );
      });
}
