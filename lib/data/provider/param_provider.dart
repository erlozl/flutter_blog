// 1. 창고 데이터
import 'package:flutter_blog/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestParam {
  int? postDetailId;
  // int? commentId;

  RequestParam({this.postDetailId});
}

// 2. 창고 (비즈니스 로직)
class ParamProvider extends RequestParam {
  // void addPostDetailId(int postId) {
  //   this.postDetailId = postId;
  // }
  //
  final mContext = navigatorKey.currentContext;
  // 저걸 클릭했을 때 상세보기 이동
}

// 3. 창고 관리자

final paramProvider = Provider<ParamProvider>((ref) {
  return ParamProvider();
});
