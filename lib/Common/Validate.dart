import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:my_web_service/Common/Constant.dart';

typedef void VoidCallBackParam(Map parameter);

class Validate {
  var data;

  Validate(this.data);

  static connectionError({
    VoidCallback method,
    VoidCallBackParam methodParam,
    Map parameters,
  }) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return errorWidget(Constant.CONNECTION_DISABLED);
    } else {
      return (emptyMap(parameters) != null
          ? methodParam(parameters)
          : method());
    }
  }

  static emptyMap(parameters) {
    return parameters.toString() == "[]" ? null : parameters;
  }

  static Widget errorWidget(String error, {String content = ""}) {
    switch (error) {
      case Constant.CONNECTION_DISABLED:
        return textError("Error in connection $content");
        break;

      case Constant.SERVER_ERROR:
        return textError("Error in server $content");
        break;

      case Constant.WIFI_DISABLED:
        return textError("Error in WiFi connection $content");
        break;

      case Constant.MESSAGE:
        return textError(content);
        break;

      default:
        return textError("Error in connection $content");
        break;
    }
  }

  static textError(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.red,
        fontSize: 40,
      ),
    );
  }

  isWidget(VoidCallBackParam method) {
    return (data is Widget)
        ? data
        : data.isNotEmpty
            ? method(json.decode(data))
            : null;
  }

  keyExists(String key, {var defaultValue}) {
    return (data.containsKey(key) && data[key] != null)
        ? data[key]
        : defaultValue;
  }
}
