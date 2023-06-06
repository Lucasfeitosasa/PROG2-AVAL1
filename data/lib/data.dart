part of 'exchange.dart';

typedef _Record = Map<String, dynamic>;

abstract class Data {
  final _data = <_Record>[];
  final _fields = <String>[];

  bool get hasData => _data.isNotEmpty;

  List<String> get fields => _fields;

  String get data;

  get delimiter => null;
  set data(String string);

  void load(String fileName) {
    final file = File(fileName);
    data = file.readAsStringSync();
  }

  void save(String fileName) {
    final file = File(fileName);
    file.createSync();
    file.writeAsStringSync(data);
  }

  void clear() {
    _data.clear();
    _fields.clear();
  }
}
