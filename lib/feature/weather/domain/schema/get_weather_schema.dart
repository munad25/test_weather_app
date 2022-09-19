class GetWeatherSchema {
  final String _appid = '45865970ebbfbc127eb2a16dd7f753e7'; 
  final String _unit = 'metric';
  final double lat;
  final double lon;
  final List<String> exclude;

  const GetWeatherSchema({
    required this.lat,
    required this.lon,
    required this.exclude,
  });

  Map<String, dynamic> build() {
    final Map<String, dynamic>  map = {
      'appid': _appid,
      'units': _unit,
      'lat': lat,
      'lon': lon,
      'exclude': exclude.join(',')
    };

    return map;
  }
  
}