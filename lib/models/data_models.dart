class Weather {
  String name, condition;
  double temp, wind, uv;
  int hum;

  Weather({
    required this.name,
    required this.condition,
    required this.temp,
    required this.wind,
    required this.uv,
    required this.hum,
  });

  factory Weather.fromJson(Map json) {
    return Weather(
      name: json['location']['name'],
      condition: json['current']['condition']['text'],
      temp: json['current']['temp_c'],
      wind: json['current']['wind_mph'],
      uv: json['current']['uv'],
      hum: json['current']['humidity'],
    );
  }
}

class News {
  String title;

  News({
    required this.title,
  });

  factory News.fromJson(Map json) {
    return News(title: json['title']);
  }
}
