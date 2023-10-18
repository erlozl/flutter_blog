// 1. 창고 데이터 ( 전역적인 것에는 창고데이터에 , stateProvider는 창고 )
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/http.dart';
import 'package:flutter_blog/_core/constants/move.dart';
import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/dto/user_request.dart';
import 'package:flutter_blog/data/model/user.dart';
import 'package:flutter_blog/data/repository/user_repository.dart';
import 'package:flutter_blog/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 로그인하고와 안하고의 차이때문에 무조건 ? 이게 필요함 null 허용
class SessionUser {
  // 1. 화면 context에 접근하는 법(화면 이동을 위해서)
  final mContext = navigatorKey.currentContext;

  User? user;
  String? jwt;
  bool isLogin;
//  토큰이 유효하면 true

  SessionUser({this.user, this.jwt, this.isLogin = false});

  Future<void> join(JoinReqDTO joinReqDTO) async {
    // 1. 통신 코드
    ResponseDTO responseDTO = await UserRepository().fetchJoin(joinReqDTO);
    // 통신 결과
    // 2. 비지니스 로직
    if (responseDTO.code == 1) {
      Navigator.pushNamed(mContext!, Move.loginPage);
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        SnackBar(
          content: Text(responseDTO.msg),
        ),
      );
    }
    // 3. 응답
  }

  Future<void> login(LoginReqDTO loginReqDTO) async {
    // 1. 통신 코드
    ResponseDTO responseDTO = await UserRepository().fetchLogin(loginReqDTO);
    // 통신 결과
    // 2. 비지니스 로직
    if (responseDTO.code == 1) {
      // 1. 세션 값 갱신
      this.user = User.fromJson(
          responseDTO.data); // as User는 정확하게 해주는 것 ( 맵 타입이면 안 들어감)
      this.jwt = responseDTO.token;
      this.isLogin = true;

      // 2. 디바이스에 JWT 저장 ( 자동 로그인 )
      await secureStorage.write(key: "jwt", value: responseDTO.token);
      // 저장 끝나고 이동하려면 await - 통신이나 IO

      // 3. 페이지 이동
      Navigator.popAndPushNamed(mContext!, Move.postListPage);
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        SnackBar(
          content: Text(responseDTO.msg),
        ),
      );
    }
    // 3. 응답
  }

  Future<void> logout() async {}
}

// 2. 창고 (stateNotifier가 아니라서 - 즉 화면 빌드 X )
// 전역적으로 만들 땐 창고 필요없다!!!!!!

// 3. 창고 관리자
final sessionProvider = Provider<SessionUser>((ref) {
  return SessionUser();
});
