import 'package:flutter/material.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/data/provider/param_provider.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/post_detail_page.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/post_detail_view_model.dart';
import 'package:flutter_blog/ui/pages/post/list_page/post_list_view_model.dart';
import 'package:flutter_blog/ui/pages/post/list_page/wiegets/post_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListBody extends ConsumerWidget {
  const PostListBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PostListModel? model = ref.watch(postListProvider); // state == null; 현재
    List<Post> posts = [];
    // 1초
    // 2초
    // 3초

    if (model != null) {
      posts = model.posts;
    } else {
      CircularProgressIndicator();
    }

    return ListView.separated(
      // separated 는 줄 그어주는것
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            // 1. postId를 paramStore에 저장
            ParamProvider paramStore = ref.read(paramProvider);
            paramStore.postDetailId = posts[index].id;
            // 2. 화면 이동

            // Detail 창고 관리자에게 post id 잔딜
            // ref.read(postDetailProvider(posts[index].id));
            // provider에 family사용해서 넘기기
            // 통신은 그 화면 열릴 때 하는 게 좋음

            // 이거는 창고를 만들고 넘어감

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PostDetailPage(),
                // post 객체를 넘김
              ),
            );
          },
          child: PostListItem(posts[index]),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
