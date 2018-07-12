/**
 * Author : F. DALLA-VALLE
 * file : weather_repo.dart
 *
 * Updating data and launching queries
 */


import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:geolocation/geolocation.dart';

import 'package:weather_app/json/response.dart';
import 'package:weather_app/model/model.dart';

class WeatherRepo{
  final http.Client client;

  //Default settings

  int day=3;
  String city;
  String country;
  String lat;
  String lon;
  bool fahrenheit = false;
  bool firstTime = true;

  WeatherRepo({this.client});

  //updates user input parameters

  Future<void> updateDay(int count){
    print("day change");
    day=count;
    return null;
  }

  Future<void> updateCity(String str){
    print("city change");
    city=str;
    return null;
  }

  Future<void> updateCountry(String str){
    print("country change");
    country=str;
    return null;
  }

  Future<void> updateLat(String str){
    print("lat change");
    lat=str;
    return null;
  }

  Future<void> updateLon(String str){
    print("lon change");
    lon=str;
    return null;
  }

  Future<void> updateFahrenheit(bool test){
    print("unit change");
    fahrenheit=!fahrenheit;
    return null;
  }

  //Launching the request

  Future<List<WeatherModel>> updateWeather(LocationResult result) async{

    String url;
    List<WeatherModel> req;

    //We check that this is not the first time we run update weather to avoid having data when we launch the application
    print("start update weather");
      //Set up to know how the user wants to search the weather
      if ((city != null) && (country != null)) {

        //search by city
        print("search by city, $city, $country, $day");
        url = 'http://api.openweathermap.org/data/2.5/forecast?q=$city,$country&cnt=$day&APPID=cd276716fd9cc04be3e53bac3b30af26';

      } else{
          //default research
          req=null;
          return req;
        }

      
      final response = await client.get(url);

      req = BaseResponse
          .fromJson(json.decode(response.body))
      //.cities
          .jours
          .map((jour) => WeatherModel.fromResponse(jour))
          .toList();

      //Unit change based on radioButton

      if (!fahrenheit) {

        //If the boolean fahrenheit is zero, Convert to degree for all items in the list
        for (int i = 0; i < req.length; i++) {

          req[i].temperature = (req[i].temperature - 32)*(5 / 9);
        }
      }
    
    return req;
  }

  Future<List<WeatherModel>> updateWeatherCoords(LocationResult result) async{

    String url;
    List<WeatherModel> req;

    //We check that this is not the first time we run update weather to avoid having data when we launch the application
    print("start update weather coords");

      //Set up to know how the user wants to search the weather

      if ((lat != null) && (lon != null)) {
      //search by coordinates
      print("search by coordinates, $lat, $lon, $day");
      url = 'http://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&cnt=$day&APPID=cd276716fd9cc04be3e53bac3b30af26';
      }else{
        //default research
        req=null;
        return req;
      }

      final response = await client.get(url);

      req = BaseResponse
          .fromJson(json.decode(response.body))
      //.cities
          .jours
          .map((jour) => WeatherModel.fromResponse(jour))
          .toList();
      //Unit change based on radioButton
      if (!fahrenheit) {
        //If the boolean fahrenheit is zero, Convert to degree for all items in the list
        for (int i = 0; i < req.length; i++) {

          req[i].temperature = (req[i].temperature - 32)*(5 / 9);
        }
      }
    return req;
  }

  //Unuse
  Future<LocationResult> updateLocation() async{
    Future<LocationResult> result = Geolocation.lastKnownLocation();
    return result;
  }

  //Unuse
  Future<bool> getGps() async{
    final GeolocationResult result = await Geolocation.isLocationOperational();
    if(result.isSuccessful)
      return true;
    else
      return false;
  }
}