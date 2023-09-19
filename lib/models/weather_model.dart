// ignore_for_file: public_member_api_docs, sort_constructors_first

class WeatherModel {
  final String cityName;
  final String countryName;
  final double temp;
  final double maxTemp;
  final double minTemp;
  final String weatherState;
  final String sunrise;
  final String sunset;
  final String date;
  WeatherModel({
    required this.cityName,
    required this.countryName,
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.weatherState,
    required this.sunrise,
    required this.sunset,
    required this.date,
  });
  factory WeatherModel.fromJson(Map<String, dynamic> jsonData) {
    return WeatherModel(
        cityName: jsonData['location']['name'],
        countryName: jsonData['location']['country'],
        temp: jsonData['current']['temp_c'],
        maxTemp: jsonData['forecast']['forecastday'][0]['day']['maxtemp_c'],
        minTemp: jsonData['forecast']['forecastday'][0]['day']['mintemp_c'],
        weatherState: jsonData['current']['condition']['text'],
        sunrise: jsonData['forecast']['forecastday'][0]['astro']['sunrise'],
        sunset: jsonData['forecast']['forecastday'][0]['astro']['sunset'],
        date: jsonData['current']['last_updated']);
  }
}


