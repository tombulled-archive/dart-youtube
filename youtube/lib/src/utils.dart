import 'dart:convert' as convert;

dynamic get(dynamic iterable, List<dynamic> keys, {dynamic fallback = null, dynamic Function(dynamic) function}) {
    for (dynamic key in keys) {
        if (
            (iterable is List && key is int && key >= 0 && key < iterable.length)
            || (iterable is Map && iterable.containsKey(key))
        ) {
            iterable = iterable[key];
        }
        else {
            return fallback;
        }
    }

    if (function != null) {
        iterable = function(iterable);
    }

    return iterable;
}

String prettyJson(Map<String, dynamic> json) {
    convert.JsonEncoder encoder = new convert.JsonEncoder.withIndent('    ');
    String prettyJsonString = encoder.convert(json);

    return prettyJsonString;
}

Map<String, dynamic> filterMap(Map<String, dynamic> map) {
    map.removeWhere (
        (key, value) => value == null
    );

    return map;
}
