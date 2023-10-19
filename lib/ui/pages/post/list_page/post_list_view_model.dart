//화면에 뿌릴 데이터를 저장한 모델을 viewModel이라고 함
// 화면에서 관리할 데이터가 없기 때문에

// 1. 창고 데이터
import 'package:flutter/material.dart';
import 'package:flutter_blog/data/dto/post_request.dart';
import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/data/provider/session_provider.dart';
import 'package:flutter_blog/data/repository/post_repository.dart';
import 'package:flutter_blog/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// model 창고데이터
// riverpod을 쓰는 이유!!
// - 공유해서 쓸 수 있어서
//데이터를 계속해서 안 넘겨도 됨
class PostListModel {
  List<Post> posts;
  PostListModel(this.posts);
}

// viewModel
// 2. 창고
class PostListViewModel extends StateNotifier<PostListModel?> {
  final mContext = navigatorKey.currentContext;

  PostListViewModel(super._state, this.ref);

  Ref ref;
  Future<void> notifyInit() async {
    SessionUser sessionUser = ref.read(sessionProvider);
    ResponseDTO responseDTO =
        await PostRepository().fetchPostList(sessionUser.jwt!);
    state = PostListModel(responseDTO.data);
  }

  Future<void> notifyAdd(PostSaveReqDTO postSaveReqDTO) async {
    SessionUser sessionUser = ref.read(sessionProvider);
    ResponseDTO responseDTO =
        await PostRepository().savePost(sessionUser.jwt!, postSaveReqDTO);

    if (responseDTO.code == 1) {
      Post newPost = responseDTO.data as Post; // 1. dynamic타입인데 실제 객체는 Post
      // 여기서 as Post는 명시적 형변환 - 근데 원래는 안해줘도 됨
      // 즉, 다운 캐스팅 코드임
      // 새로운 글쓰기이기 때문에 newPost라고 한다

      List<Post> posts = state!.posts;
      // 상태 값 안에 이 post가 있다 = 현재 상태의 값을 다른 변수에다가 이동 시킴

      // 상태 값 갱신하기
      List<Post> newPosts = [newPost, ...posts]; // 2 기존 상태에 데이터 추가 ( 전개 연산자 )
      // 최신꺼를 앞에 놔둬야 하기 때문에 newPost가 앞에 있어야 함
      state = PostListModel(newPosts);
      // newPost의 타입이 List이기 때문에 state에 들어가려면 PostListModel에 넣어주면 된다
      // 3. ViewModel 창고 데이터 갱신이 완료 - watch 구독자는 rebuild됨

      Navigator.pop(mContext!); // 글쓰기 화면 pop
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
        SnackBar(
          content: Text("게시물 작성 실패 : ${responseDTO.msg}"),
        ),
      );
    }
  }
}

// 3. 창고 관리자 (View 빌드되기 직전에 생성됨)
final postListProvider =
    StateNotifierProvider<PostListViewModel, PostListModel?>((ref) {
  return PostListViewModel(null, ref)..notifyInit();
});
