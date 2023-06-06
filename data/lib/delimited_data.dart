part of 'exchange.dart';

abstract class DelimitedData extends Data {
  @override
  String get delimiter;

  List<List<String>> readData(String filePath);
}
