abstract class WeatherStates{}
class WeatherInitial extends WeatherStates{}
class GetWeatherLoadingState extends WeatherStates{}
class GetWeatherSuccessState extends WeatherStates{}
class GetWeatherFailureState extends WeatherStates{}
class GetLocationLoadingState extends WeatherStates{}
class GetLocationSuccessState extends WeatherStates{}
class GetLocationFailureState extends WeatherStates{}
class GetCitiesSuccessState extends WeatherStates{}
class GetConnectivitySuccessState extends WeatherStates{}
class GetConnectivityFailureState extends WeatherStates{}