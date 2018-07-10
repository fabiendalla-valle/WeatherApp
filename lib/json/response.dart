/**
 * Author : F. DALLA-VALLE
 * file : response.dart
 *
 *Response from our JSON file, adapted to an object
 */


import 'package:json_annotation/json_annotation.dart';
part 'response.g.dart';
@JsonSerializable()
class BaseResponse extends Object with _$BaseResponseSerializerMixin{
  final String cod;
 // final String message;
  final double message;
  final int cnt;

  @JsonKey(name:"list")
  final List<Jour> jours;
 // final List<City> cities;

  final City city;

  BaseResponse(this.cod, this.message, this.cnt, this.jours, this.city);

  factory BaseResponse.fromJson(Map<String,dynamic> json) => _$BaseResponseFromJson(json);
}
/*
@JsonSerializable()
class City extends Object with _$CitySerializerMixin{
  final int id;
  final String name;
  final Coord coord;
  final Main main;
  final int dt;
  @JsonKey(nullable: true)
  final Wind wind;
  @JsonKey(nullable: true)
  final Rain rain;
  final Clouds clouds;
  final List<Weather> weather;

  City(this.id, this.name, this.coord, this.main, this.dt, this.wind, this.rain,
      this.clouds, this.weather);

  factory City.fromJson(Map<String,dynamic> json)=>_$CityFromJson(json);

}
*/
@JsonSerializable()
class Jour extends Object with _$JourSerializerMixin{
  final int dt;
  final Main main;
  final List<Weather> weather;
  final Clouds clouds;
  @JsonKey(nullable: true)
  final Wind wind;
  @JsonKey(nullable: true)
  final Rain rain;
  final Sys sys;
  final String dtTxt;


  Jour(this.dt, this.main, this.weather, this.clouds, this.wind, this.rain,
      this.sys, this.dtTxt);

  factory Jour.fromJson(Map<String,dynamic> json)=>_$JourFromJson(json);

}

@JsonSerializable()
class City extends Object with _$CitySerializerMixin{
  final int id;
  final String name;
  final Coord coord;
  final String country;
  final double population;

  City(this.id, this.name, this.coord, this.country, this.population);

  factory City.fromJson(Map<String,dynamic> json)=>_$CityFromJson(json);

}
@JsonSerializable()
class Coord extends Object with _$CoordSerializerMixin{
  final double lat;
  final double lon;

  Coord(this.lat, this.lon);

  factory Coord.fromJson(Map<String,dynamic> json)=> _$CoordFromJson(json);
}

@JsonSerializable()
class Main extends Object with _$MainSerializerMixin{
  final double temp;
  @JsonKey(name: "temp_min")
  final double tempMin;
  @JsonKey(name:"temp_max")
  final double tempMax;
  final double pressure;
  @JsonKey(name:"sea_level")
  final double seaLevel;
  @JsonKey(name:"grnd_level")
  final double grndLevel;
  final int humidity;
  @JsonKey(name:"temp_kf")
  final double tempKf;

  Main(this.temp, this.tempMin, this.tempMax, this.pressure, this.seaLevel,
      this.grndLevel, this.humidity, this.tempKf);

  factory Main.fromJson(Map<String,dynamic> json)=>_$MainFromJson(json);

}

@JsonSerializable()
class Wind extends Object with _$WindSerializerMixin{
  final double speed;
  final double deg;


  Wind(this.speed, this.deg);

  factory Wind.fromJson(Map<String,dynamic> json)=>_$WindFromJson(json);

}

@JsonSerializable()
class Rain extends Object with _$RainSerializerMixin{
  @JsonKey(name: "3h")
  final double threeHour;

  Rain(this.threeHour);

  factory Rain.fromJson(Map<String,dynamic> json)=>_$RainFromJson(json);

}

@JsonSerializable()
class Clouds extends Object with _$CloudsSerializerMixin{
final int all;

Clouds(this.all);

factory Clouds.fromJson(Map<String,dynamic> json)=>_$CloudsFromJson(json);

}

@JsonSerializable()
class Weather extends Object with _$WeatherSerializerMixin{
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather(this.id, this.main, this.description, this.icon);

  factory Weather.fromJson(Map<String,dynamic> json)=>_$WeatherFromJson(json);

}

@JsonSerializable()
class Sys extends Object with _$SysSerializerMixin{
  final String pod;

  Sys(this.pod);

  factory Sys.fromJson(Map<String,dynamic> json)=>_$SysFromJson(json);

}