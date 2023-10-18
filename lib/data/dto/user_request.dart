// 리플렉션도 하나의 스레드로 도는데 flutter는 단일스레드라서
// 롬북을 사용못함
class JoinReqDTO {
  String username;
  String password;
  String email;

  JoinReqDTO({
    required this.username,
    required this.password,
    required this.email,
  });

  // 내 object를 json 서버로 던지기
  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "email": email,
      };
}

class LoginReqDTO {
  final String username;
  final String password;

  LoginReqDTO({
    required this.username,
    required this.password,
  });
  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
