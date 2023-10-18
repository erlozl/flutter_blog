// 요청 순서 : View -> provider(전역, vidwModel) ㅡ> repository
import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/dto/user_request.dart';
import 'package:flutter_blog/data/model/user.dart';

import '../../_core/constants/http.dart';

// 통신!!!!!!!! 파싱!!!!!!!!

class UserRepository {
  Future<ResponseDTO> fetchJoin(JoinReqDTO requestDTO) async {
    // 통신은 try Catch로 무조건 묶기
    try {
      final response = await dio.post("/join", data: requestDTO.toJson());
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      // responseDTO.data = User.fromJson(responseDTO.data);
      // 프론트엔드역량

      // 현재 data타입은 dynamic, User 객체는 자바로 치면 object
      return responseDTO;
      // ㅡ> 응답 바디
    } catch (e) {
      //200이 아니면 catch로 감
      return ResponseDTO(-1, "중복되는 유저명입니다", null);
    }
  }

  Future<ResponseDTO> fetchLogin(LoginReqDTO requestDTO) async {
    // 통신은 try Catch로 무조건 묶기
    try {
      final response = await dio.post("/login", data: requestDTO.toJson());
      print(response.data);
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      // responseDTO.data = User.fromJson(responseDTO.data);
      // 프론트엔드역량

      final jwt = response.headers["Authorization"];

      // List<String>? = 정확한 타입
      if (jwt != null) {
        responseDTO.token = jwt.first;
      }

      // 현재 data타입은 dynamic, User 객체는 자바로 치면 object
      return responseDTO;
      // ㅡ> 응답 바디
    } catch (e) {
      //200이 아니면 catch로 감
      return ResponseDTO(-1, "유저네임 혹은 패스워드가 틀렸습니다", null);
    }
  }
}
