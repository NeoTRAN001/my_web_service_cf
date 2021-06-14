import 'package:my_web_service/Common/Constant.dart';
import 'package:my_web_service/HttpProtocol/HTTPExecute.dart';

class EndPoint {
  static getUser(id) {
    return HTTPExecute(generateEndPointURL("user/$id")).get();
  }

  static getPost(id) {
    return HTTPExecute(generateEndPointURL("posts")).get();
  }

  static insertPost(parameters) {
    return HTTPExecute(generateEndPointURL("posts")).post(parameters);
  }

  static updatePost(parameters) {
    return HTTPExecute(generateEndPointURL("posts/${parameters['id']}"))
        .put(parameters);
  }

  static deletePost(id) {
    return HTTPExecute(generateEndPointURL("posts/$id")).delete();
  }

  static generateEndPointURL(resource) {
    return Constant.DOMAIN + "${Constant.PATH}$resource";
  }
}
