class Weather {
  Weather({
    required this.location,
    required this.current,
    required this.forecast,
  });
  late final WeatherLocation location;
  late final Current current;
  late final Forecast forecast;

  Weather.fromJson(Map<String, dynamic> json) {
    location = WeatherLocation.fromJson(json['location']);
    current = Current.fromJson(json['current']);
    forecast = Forecast.fromJson(json['forecast']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['location'] = location.toJson();
    _data['current'] = current.toJson();
    _data['forecast'] = forecast.toJson();
    return _data;
  }
}

class WeatherLocation {
  WeatherLocation({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtimeEpoch,
    required this.localtime,
  });
  late final String name;
  late final String region;
  late final String country;
  late final double lat;
  late final double lon;
  late final String tzId;
  late final int localtimeEpoch;
  late final String localtime;

  WeatherLocation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    region = json['region'];
    country = json['country'];
    lat = json['lat'];
    lon = json['lon'];
    tzId = json['tz_id'];
    localtimeEpoch = json['localtime_epoch'];
    localtime = json['localtime'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['region'] = region;
    _data['country'] = country;
    _data['lat'] = lat;
    _data['lon'] = lon;
    _data['tz_id'] = tzId;
    _data['localtime_epoch'] = localtimeEpoch;
    _data['localtime'] = localtime;
    return _data;
  }
}

class Current {
  Current({
    required this.tempC,
    required this.condition,
    required this.humidity,
  });
  late final double tempC;
  late final Condition condition;
  late final int humidity;

  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];
    condition = Condition.fromJson(json['condition']);
    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['temp_c'] = tempC;
    _data['condition'] = condition.toJson();
    _data['humidity'] = humidity;
    return _data;
  }
}

class Condition {
  Condition({
    required this.text,
    required this.code,
  });
  late final String text;
  late final int code;

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['text'] = text;
    _data['code'] = code;
    return _data;
  }
}

class Forecast {
  Forecast({
    required this.forecastday,
  });
  late final List<Forecastday> forecastday;

  Forecast.fromJson(Map<String, dynamic> json) {
    forecastday = List.from(json['forecastday'])
        .map((e) => Forecastday.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['forecastday'] = forecastday.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Forecastday {
  Forecastday({
    required this.date,
    required this.day,
    required this.astro,
    required this.hour,
  });
  late final String date;
  late final Day day;
  late final Astro astro;
  late final List<Hour> hour;

  Forecastday.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = Day.fromJson(json['day']);
    astro = Astro.fromJson(json['astro']);
    hour = List.from(json['hour']).map((e) => Hour.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['date'] = date;
    _data['day'] = day.toJson();
    _data['astro'] = astro.toJson();
    _data['hour'] = hour.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Day {
  Day({
    required this.maxtempC,
    required this.mintempC,
    required this.condition,
  });
  late final double maxtempC;
  late final double mintempC;
  late final Condition condition;

  Day.fromJson(Map<String, dynamic> json) {
    maxtempC = json['maxtemp_c'];
    mintempC = json['mintemp_c'];
    condition = Condition.fromJson(json['condition']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['maxtemp_c'] = maxtempC;
    _data['mintemp_c'] = mintempC;
    _data['condition'] = condition.toJson();
    return _data;
  }
}

class Astro {
  Astro();

  Astro.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}

class Hour {
  Hour({
    required this.time,
    required this.tempC,
    required this.condition,
  });
  late final String time;
  late final double? tempC;
  late final Condition condition;

  Hour.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    tempC = json['temp_c'];
    condition = Condition.fromJson(json['condition']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['time'] = time;
    _data['temp_c'] = tempC;
    _data['condition'] = condition.toJson();
    return _data;
  }
}
