//화면에 뿌릴 데이터를 저장한 모델을 viewModel이라고 함
// 화면에서 관리할 데이터가 없기 때문에

// 1. 창고 데이터
import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/data/provider/session_provider.dart';
import 'package:flutter_blog/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// model 창고데이터
class PostListModel {
  List<Post> posts;
  PostListModel(this.posts);
}

// viewModel
// 2. 창고
class PostListViewModel extends StateNotifier<PostListModel?> {
  PostListViewModel(super._state, this.ref);

  Ref ref;
  Future<void> notifyInit() async {
    SessionUser sessionUser = ref.read(sessionProvider);
    ResponseDTO responseDTO =
        await PostRepository().fetchPostList(sessionUser.jwt!);
    state = PostListModel(responseDTO.data);
  }
}

// 3. 창고 관리자 (View 빌드되기 직전에 생성됨)
final postListProvider =
    StateNotifierProvider<PostListViewModel, PostListModel?>((ref) {
  return PostListViewModel(null, ref)..notifyInit();
});
