part of 'exchange.dart';

class XmlData extends Data {
  static const headerElement = '<?xml version="1.0" encoding="UTF-8"?>';
  static const dataElemName = 'data';
  static const recordElemName = 'record';

  @override
  String get data {
    String xml = '$headerElement\n';

    xml += '<$dataElemName>\n';
    for (var elem in _data) {
      final record = buildRecordElement(elem);
      xml += '$record/>\n';
    }
    xml += '</$dataElemName>\n';

    return xml;
  }

  @override
  set data(String string) {
    final xml = XmlDocument.parse(string);
    final dataElem = xml.getElement(dataElemName);

    validateFormat(dataElem);

    clear();

    for (var elem in dataElem!.childElements) {
      final map = extractAttributes(elem);
      _data.add(map);
    }
  }

  String buildRecordElement(elem) {
    final record = elem.entries.fold<String>(
      '  <$recordElemName ',
      (lastValue, entry) {
        final quote = entry.value is num ? '' : '"';
        return '$lastValue${entry.key}=$quote${entry.value}$quote ';
      },
    );
    return record;
  }

  void validateFormat(dataElem) {
    if (dataElem == null) {
      throw InvalidFormat('Invalid XML format: "data" element not found');
    }

    final records = dataElem.childElements;
    if (records.any((elem) => elem.localName != recordElemName)) {
      throw InvalidFormat('Invalid XML format: invalid element name');
    }
  }

  Map<String, dynamic> extractAttributes(elem) {
    final map = <String, dynamic>{};
    for (var attr in elem.attributes) {
      map[attr.localName] = attr.value;

      if (!_fields.contains(attr.localName)) {
        _fields.add(attr.localName);
      }
    }
    return map;
  }
}