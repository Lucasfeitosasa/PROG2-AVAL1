part of 'exchange.dart';

class CsvData extends DelimitedData {
  @override
  String get delimiter => ',';

  @override
  List<List<String>> readData(String filePath) {
    return [];
  }

  @override
  late String data;
}
