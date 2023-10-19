// 창고 데이터
import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/data/provider/param_provider.dart';
import 'package:flutter_blog/data/provider/session_provider.dart';
import 'package:flutter_blog/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class PostDetailModel {
  int? id;
  Post post;
  PostDetailModel(this.post);
}

// 창고
class PostDetailViewModel extends StateNotifier<PostDetailModel?> {
  // 통신으로 받을 거 아니면 null 이 될 수 없다
  PostDetailViewModel(super._state, this.ref);
  Ref ref;

  // void param(int id) {
  //   state!.id = id;
  // } // 이것도 통신을 통해서 id 들고와서 뿌릴 수 있음

  Future<void> notifyInit(int id) async {
    Logger().d("notifyInit");
    SessionUser sessionUser = ref.read(sessionProvider);
    ResponseDTO responseDTO =
        await PostRepository().fetchPost(sessionUser.jwt!, id);
    state = PostDetailModel(responseDTO.data);
  }
}

// 창고 관리자
final postDetailProvider =
// 창고관리자한테 무엇인가 데이터를 전달하는 기법( 창고가 아닌!! )
// .famaily는 직접 파라미터 전달
    StateNotifierProvider.autoDispose<PostDetailViewModel, PostDetailModel?>(
        (ref) {
  int postId = ref.read(paramProvider).postDetailId!;
  return PostDetailViewModel(null, ref)..notifyInit(postId);
});
