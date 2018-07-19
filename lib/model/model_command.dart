/**
 * Author : F. DALLA-VALLE
 * file : model_command.dart
 *
 *Order declaration
 */


import 'package:rx_command/rx_command.dart';
import 'package:geolocation/geolocation.dart';
import 'package:weather_app/model/model.dart';
import 'package:weather_app/model/weather_repo.dart';

class ModelCommand{
  final WeatherRepo weatherRepo;

 // final RxCommand<Null,LocationResult> updateLocationCommand;
  final RxCommand<dynamic, LocationResult> updateLocationStreamCommand;
  final RxCommand<LocationResult, List<WeatherModel>> updateWeatherCommand;

  final RxCommand<LocationResult, List<WeatherModel>> updateWeatherCommandCoords;
  final RxCommand<LocationResult, List<WeatherModel>> updateWeatherCommandGeo;

  final RxCommand<Null,bool> getGpsCommand;

  final RxCommand<bool,void> radioCheckedCommand;

  final RxCommand<int,void> addDayCommand;
  final RxCommand<String,void> addCityCommand;
  final RxCommand<String,void> addCountryCommand;
  final RxCommand<String,void> addLatCommand;
  final RxCommand<String,void> addLonCommand;


  ModelCommand._(this.weatherRepo, this.updateLocationStreamCommand,
      this.updateWeatherCommand,this.updateWeatherCommandCoords,this.updateWeatherCommandGeo, this.getGpsCommand, this.radioCheckedCommand,
      this.addDayCommand, this.addCityCommand, this.addCountryCommand,
      this.addLatCommand, this.addLonCommand);

  factory ModelCommand(WeatherRepo repo){
    final _getGpsCommand = RxCommand.createAsync2<bool>(repo.getGps);

    //final _radioCheckedCommand = RxCommand.createAsync3<bool,bool>((b)async =>b);
    final _radioCheckedCommand = RxCommand.createAsync3<bool,void>(repo.updateFahrenheit);

    final _updateLocationStreamCommand=RxCommand.createFromStream<dynamic, LocationResult>(repo.updateLocationStream);

    final _updateWeatherCommand = RxCommand.createAsync3<LocationResult,List<WeatherModel>>(repo.updateWeather);
    final _updateWeatherCommandCoords = RxCommand.createAsync3<LocationResult,List<WeatherModel>>(repo.updateWeatherCoords);
    final _updateWeatherCommandGeo = RxCommand.createAsync3<LocationResult,List<WeatherModel>>(repo.updateWeatherGeo);

    final _addDayCommand = RxCommand.createAsync3<int,void>(repo.updateDay);
    final _addCityCommand = RxCommand.createAsync3<String,void>(repo.updateCity);
    final _addCountryCommand = RxCommand.createAsync3<String,void>(repo.updateCountry);
    final _addLatCommand = RxCommand.createAsync3<String,void>(repo.updateLat);
    final _addLonCommand = RxCommand.createAsync3<String,void>(repo.updateLon);
    /*
    _updateLocationCommand.results.listen((data)=> _updateWeatherCommand(data));
    _updateWeatherCommand(null);
    */
    return ModelCommand._(
    repo,
    _updateLocationStreamCommand,
    _updateWeatherCommand,
    _updateWeatherCommandCoords,
    _updateWeatherCommandGeo,
    _getGpsCommand,
    _radioCheckedCommand,
    _addDayCommand,
    _addCityCommand,
    _addCountryCommand,
    _addLatCommand,
    _addLonCommand
    );

  }

}