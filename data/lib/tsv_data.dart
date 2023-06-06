part of 'exchange.dart';

class TsvData extends DelimitedData {
  @override
  String get delimiter => '\t';

  @override
  List<List<String>> readData(String filePath) {
    return [];
  }

  @override
  late String data;
}
