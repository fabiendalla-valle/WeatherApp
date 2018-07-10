/**
 * Author : F. DALLA-VALLE
 * file : model.dart
 *
 *Declaration of our model
 */


import 'package:weather_app/json/response.dart';
class WeatherModel{
  final int city;
  //The temperature is not final as we change the unit in weather_repo
  double temperature;
  final String description;
  final String icon;

  WeatherModel(this.city, this.temperature, this.description, this.icon,);
  WeatherModel.fromResponse(Jour response)
      : city=response.dt,
        temperature=(response.main.temp*(9/5))-459.67,
        description=response.weather[0]?.description,
        icon=response.weather[0]?.icon;
}