import 'package:http/http.dart' as http;
import 'package:my_web_service/Common/Constant.dart';
import 'package:my_web_service/Common/Validate.dart';

class HTTPExecute {
  String endPointUrl;
  HTTPExecute(this.endPointUrl);

  get() async {
    return await Validate.connectionError(method: loadGet);
  }

  post(Map parameters) async {
    return await Validate.connectionError(
      methodParam: loadPost,
      parameters: parameters,
    );
  }

  delete() async {
    return await Validate.connectionError(method: loadGet);
  }

  put(Map parameters) async {
    return await Validate.connectionError(
      methodParam: loadPut,
      parameters: parameters,
    );
  }

  loadGet() async {
    var response = await http.get(this.endPointUrl);
    validateResponse(response);
  }

  loadPost(Map parameters) async {
    var response = await http.post(this.endPointUrl, body: parameters);
    validateResponse(response);
  }

  loadDelete() async {
    var response = await http.delete(this.endPointUrl);
    validateResponse(response);
  }

  loadPut(Map parameters) async {
    var response = await http.put(this.endPointUrl, body: parameters);
    validateResponse(response);
  }

  validateResponse(response) {
    return (response.statusCode >= 200 && response.statusCode < 300)
        ? response.body.toString()
        : Validate.errorWidget(
            Constant.SERVER_ERROR,
            content: response.statusCode.toString(),
          );
  }
}
