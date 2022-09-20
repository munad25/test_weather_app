import 'package:get_storage/get_storage.dart';

class LocalData {
  final _latestUpdateKey = 'latest-update';
  final _positionKey = 'latest-position';
  final _storage = GetStorage();
  
  Future<void> setLatestUpdate(DateTime date) async {
    await _storage.write(_latestUpdateKey, date.toIso8601String());
  }

  Future<DateTime> getLatestUpdate() async {
    final localDate = await _storage.read(_latestUpdateKey);
    late DateTime date;
    
    if(localDate != null) {
      return DateTime.parse(localDate);
    } else {
      return DateTime.now();
    }
  }

  Future<void> setLatestPosition(String position) async {
    await _storage.write(_positionKey, position);
  }

  Future<String?> getLatestPosition() async {
    return await _storage.read(_positionKey);
  }
  
}
