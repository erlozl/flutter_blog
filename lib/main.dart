import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/move.dart';
import 'package:flutter_blog/_core/constants/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO 1: Widget이 아닌 고에서 현재 화면이 contedxt에 접근해주는 객체
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// ㅡ> alert창 같은 것을 띄우려면, ViewModel 같은 건 위젯이 아니기 때문에 context가 없음
// context가 있어야 화면을 띄울 수 있는데 이게 Globalkey가 그 역할을 함

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey:
          navigatorKey, // context가 없는 곳에서 context를 사용할 수 있는 방법 (몰라도 됨)
      debugShowCheckedModeBanner: false,
      initialRoute: Move.loginPage,
      routes: getRouters(),
      theme: theme(),
    );
  }
}
