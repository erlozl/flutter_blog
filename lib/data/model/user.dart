import 'package:intl/intl.dart';

//이 형태는 똑같다
class User {
  int id;
  String username;
  String email;
  DateTime created;
  DateTime updated;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.created,
    required this.updated,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "created": created,
        "updated": updated
      };

  User.fromJson(Map<String, dynamic> json)
      // 생성자가 실행되면 초기화가 되어야 하는데,
      // 생성자 만들고 나서 new하고 나서 내부를 실행
      // 타이밍 상 필드 초기화가 안됨
      // 즉, 이니셜라이즈드 키워드를 사용하면
      // New하기 전에 객체 만들어질 때 초기화하고 객체가 만들어짐
      : id = json["id"],
        username = json["username"],
        email = json["email"],
        created = DateFormat("yyyy-mm-dd").parse(json["created"]), // 3
        updated = DateFormat("yyyy-mm-dd").parse(json["updated"]);
}
