import 'package:my_web_service/Common/Validate.dart';
import 'package:my_web_service/HttpProtocol/EndPoint.dart';

class User {
  int id;
  String name;
  String userName;
  String email;
  String image;

  User(
      {this.id = 0,
      this.name = '',
      this.userName = '',
      this.email = '',
      this.image = ''});

  factory User.fromJson(Map<dynamic, dynamic> data) {
    if (data == null) return null;
    Validate validate = Validate(data);
    return User(
        id: validate.keyExists('id', defaultValue: 0),
        name: validate.keyExists('name'),
        userName: validate.keyExists('username'),
        email: validate.keyExists('email'),
        image: validate.keyExists('image'));
  }

  Future getUser(id) async {
    var data = await EndPoint.getUser(id);
    return Validate(data).isWidget(getObject);
  }

  getObject(data) {
    return User.fromJson(data);
  }
}
