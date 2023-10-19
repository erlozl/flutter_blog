import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/size.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/data/provider/session_provider.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/post_detail_view_model.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/widgets/post_detail_buttons.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/widgets/post_detail_content.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/widgets/post_detail_profile.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/widgets/post_detail_title.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailBody extends ConsumerWidget {
  const PostDetailBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
//    상세보기 viewModel을 받아서 넣던지, PostListModel에 객체를 넣어서 집어넣는 거 좋다
    // TODO 3: watch? read?
    PostDetailModel? model = ref.watch(postDetailProvider);
    // 처음에는 빈 화면 , 데이터가 생겼을 때 watch가 감지 - 리빌드함

    // read는 창고 데이터에 바로 접근 가능
    // PostDetailModel? pdm2 = ref.watch(postDetailProvider); // 상태에 접근
    // ref.read(postDetailProvider.notifier); // 창고 접근

    if (model == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      );
    } else {
      Post post = model!.post; // 절대 바뀔리 없어서 !
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            PostDetailTitle("${post.title}"),
            const SizedBox(height: largeGap),
            PostDetailProfile(),
            PostDetailButtons(),
            const Divider(),
            const SizedBox(height: largeGap),
            PostDetailContent("${post.content}"),
          ],
        ),
      );
    }
  }
}
