typedef bool SelectFunction<T>(T item);

abstract class CashServiceInterface {
  void init();
  void dispose();

  T? get<T>(String key);
  void set<T>(String key, T value);
  void delete(String key);

  // list functions
  void createList(String listName);
  void addToList<T>(String listName, T item);
  void removeFromList<T>(String listName, SelectFunction<T> fn);
  List<T> fetchFromList<T>(String listName, SelectFunction<T> fn);

  void clear();
}
