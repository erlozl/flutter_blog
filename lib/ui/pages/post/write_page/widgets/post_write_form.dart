import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/size.dart';
import 'package:flutter_blog/_core/utils/validator_util.dart';
import 'package:flutter_blog/data/dto/post_request.dart';
import 'package:flutter_blog/ui/pages/post/list_page/post_list_view_model.dart';
import 'package:flutter_blog/ui/widgets/custom_elavated_button.dart';
import 'package:flutter_blog/ui/widgets/custom_text_area.dart';
import 'package:flutter_blog/ui/widgets/custom_text_form_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class PostWriteForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _content = TextEditingController();

  PostWriteForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          CustomTextFormField(
            controller: _title,
            hint: "Title",
            funValidator: validateTitle(),
          ),
          const SizedBox(height: smallGap),
          CustomTextArea(
            controller: _content,
            hint: "Content",
            funValidator: validateContent(),
          ),
          const SizedBox(height: largeGap),
          CustomElevatedButton(
            text: "글쓰기",
            funPageRoute: () async {
              if (_formKey.currentState!.validate()) {
                // 이 뷰에 상태는 list_page를 바꾸고 싶은 거기 때문에
                // 이미 view_model있기 때문에 새로 안 만들어도 됨
                // 모든 페이지마다 viewModel이 있는 게 아님
                // 화면에 데이터가 있어야 viewModel필요한 거임!!!!!
                Logger().d("title : ${_title.text}");
                // Logger사용하자 - 이게 더 잘 보임
                print("title : ${_content.text}");

                PostSaveReqDTO postSaveReqDTO = PostSaveReqDTO(
                  title: _title.text,
                  content: _content.text,
                );
                ref.read(postListProvider.notifier).notifyAdd(postSaveReqDTO);
                // pop을 하면 notifyinit이 실행안됨 - 뒤로가기이기 때문에
                // 서버측에 실행이 아무것도 안됨
                // 객체가 이미 그려져 있기 때문에 그냥 뒤로가기만 됨

                // pop해도 상태가 변경됐기 때문에 , 상태 값을 추가하는 거기 때문에
                // 그 안에서 변경된다
              }
            },
          ),
        ],
      ),
    );
  }
}
