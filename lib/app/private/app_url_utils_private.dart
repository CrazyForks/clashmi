import 'package:flutter/foundation.dart';

abstract final class AppUrlUtilsPrivate {
  static bool _loggedFallback = false;

  static String signQueryParams(
    String version,
    String bodyLen,
    Map<String, dynamic> params,
  ) {
    return signQueryParams2(version, params, bodyLen: bodyLen);
  }

  static String signQueryParams2(
    String version,
    Map<String, dynamic> params, {
    String bodyLen = "0",
  }) {
    if (!_loggedFallback) {
      _loggedFallback = true;
      debugPrint(
        'AppUrlUtilsPrivate fallback signing is active; private signing key is not available.',
      );
    }

    final values = <String, String>{
      'version': version,
      'body_len': bodyLen,
      for (final entry in params.entries) entry.key: entry.value.toString(),
    };

    final keys = values.keys.toList()..sort();
    return keys.map((key) => '$key=${values[key] ?? ''}').join('&');
  }
}
