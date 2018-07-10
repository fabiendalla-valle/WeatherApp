// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) =>
    new BaseResponse(
        json['cod'] as String,
        (json['message'] as num)?.toDouble(),
        json['cnt'] as int,
        (json['list'] as List)
            ?.map((e) =>
                e == null ? null : new Jour.fromJson(e as Map<String, dynamic>))
            ?.toList(),
        json['city'] == null
            ? null
            : new City.fromJson(json['city'] as Map<String, dynamic>));

abstract class _$BaseResponseSerializerMixin {
  String get cod;
  double get message;
  int get cnt;
  List<Jour> get jours;
  City get city;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'cod': cod,
        'message': message,
        'cnt': cnt,
        'list': jours,
        'city': city
      };
}

Jour _$JourFromJson(Map<String, dynamic> json) => new Jour(
    json['dt'] as int,
    json['main'] == null
        ? null
        : new Main.fromJson(json['main'] as Map<String, dynamic>),
    (json['weather'] as List)
        ?.map((e) =>
            e == null ? null : new Weather.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['clouds'] == null
        ? null
        : new Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
    json['wind'] == null
        ? null
        : new Wind.fromJson(json['wind'] as Map<String, dynamic>),
    json['rain'] == null
        ? null
        : new Rain.fromJson(json['rain'] as Map<String, dynamic>),
    json['sys'] == null
        ? null
        : new Sys.fromJson(json['sys'] as Map<String, dynamic>),
    json['dtTxt'] as String);

abstract class _$JourSerializerMixin {
  int get dt;
  Main get main;
  List<Weather> get weather;
  Clouds get clouds;
  Wind get wind;
  Rain get rain;
  Sys get sys;
  String get dtTxt;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'dt': dt,
        'main': main,
        'weather': weather,
        'clouds': clouds,
        'wind': wind,
        'rain': rain,
        'sys': sys,
        'dtTxt': dtTxt
      };
}

City _$CityFromJson(Map<String, dynamic> json) => new City(
    json['id'] as int,
    json['name'] as String,
    json['coord'] == null
        ? null
        : new Coord.fromJson(json['coord'] as Map<String, dynamic>),
    json['country'] as String,
    (json['population'] as num)?.toDouble());

abstract class _$CitySerializerMixin {
  int get id;
  String get name;
  Coord get coord;
  String get country;
  double get population;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'coord': coord,
        'country': country,
        'population': population
      };
}

Coord _$CoordFromJson(Map<String, dynamic> json) => new Coord(
    (json['lat'] as num)?.toDouble(), (json['lon'] as num)?.toDouble());

abstract class _$CoordSerializerMixin {
  double get lat;
  double get lon;
  Map<String, dynamic> toJson() => <String, dynamic>{'lat': lat, 'lon': lon};
}

Main _$MainFromJson(Map<String, dynamic> json) => new Main(
    (json['temp'] as num)?.toDouble(),
    (json['temp_min'] as num)?.toDouble(),
    (json['temp_max'] as num)?.toDouble(),
    (json['pressure'] as num)?.toDouble(),
    (json['sea_level'] as num)?.toDouble(),
    (json['grnd_level'] as num)?.toDouble(),
    json['humidity'] as int,
    (json['temp_kf'] as num)?.toDouble());

abstract class _$MainSerializerMixin {
  double get temp;
  double get tempMin;
  double get tempMax;
  double get pressure;
  double get seaLevel;
  double get grndLevel;
  int get humidity;
  double get tempKf;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'temp': temp,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'pressure': pressure,
        'sea_level': seaLevel,
        'grnd_level': grndLevel,
        'humidity': humidity,
        'temp_kf': tempKf
      };
}

Wind _$WindFromJson(Map<String, dynamic> json) => new Wind(
    (json['speed'] as num)?.toDouble(), (json['deg'] as num)?.toDouble());

abstract class _$WindSerializerMixin {
  double get speed;
  double get deg;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'speed': speed, 'deg': deg};
}

Rain _$RainFromJson(Map<String, dynamic> json) =>
    new Rain((json['3h'] as num)?.toDouble());

abstract class _$RainSerializerMixin {
  double get threeHour;
  Map<String, dynamic> toJson() => <String, dynamic>{'3h': threeHour};
}

Clouds _$CloudsFromJson(Map<String, dynamic> json) =>
    new Clouds(json['all'] as int);

abstract class _$CloudsSerializerMixin {
  int get all;
  Map<String, dynamic> toJson() => <String, dynamic>{'all': all};
}

Weather _$WeatherFromJson(Map<String, dynamic> json) => new Weather(
    json['id'] as int,
    json['main'] as String,
    json['description'] as String,
    json['icon'] as String);

abstract class _$WeatherSerializerMixin {
  int get id;
  String get main;
  String get description;
  String get icon;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'main': main,
        'description': description,
        'icon': icon
      };
}

Sys _$SysFromJson(Map<String, dynamic> json) => new Sys(json['pod'] as String);

abstract class _$SysSerializerMixin {
  String get pod;
  Map<String, dynamic> toJson() => <String, dynamic>{'pod': pod};
}
