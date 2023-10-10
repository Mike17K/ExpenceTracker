import 'package:expenses_tracker/services/cashv2/cashv2_service_interface.dart';

class Cashv2 implements CashServiceInterface {
  late Map<String, dynamic> _cashKeyValuePairs;
  late Map<String, List<dynamic>> _cashLists;

  Map<String, dynamic> get allPairs => _cashKeyValuePairs;
  Map<String, List<dynamic>> get allLists => _cashLists;

  @override
  void init() {
    _cashKeyValuePairs = {};
    _cashLists = {};
  }

  @override
  void dispose() {
    _cashKeyValuePairs = {};
    _cashLists = {};
  }

  @override
  void addToList<T>(String listName, T item) {
    _cashLists[listName]!.add(item);
  }

  @override
  void clear() {
    _cashKeyValuePairs = {};
    _cashLists = {};
  }

  @override
  void createList(String listName) {
    _cashLists[listName] = [];
  }

  @override
  void delete(String key) {
    _cashKeyValuePairs.remove(key);
  }

  @override
  List<T> fetchFromList<T>(String listName, SelectFunction<T> fn) {
    return _cashLists[listName]!.where((item) => fn(item)).toList() as List<T>;
  }

  @override
  T? get<T>(String key) {
    return _cashKeyValuePairs[key];
  }

  @override
  void removeFromList<T>(String listName, SelectFunction<T> fn) {
    _cashLists[listName]!.removeWhere((item) => fn(item));
  }

  @override
  void set<T>(String key, T value) {
    _cashKeyValuePairs[key] = value;
  }
}
