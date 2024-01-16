import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
void main() async {
  // main() 함수에서 async를 쓰려면 필요
  WidgetsFlutterBinding.ensureInitialized();

  // shared_preferences 인스턴스 생성
  prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SharedPreferences에서 온보딩 완료 여부 조회
    // isOnboarded에 해당하는 값에서 null을 반환하는 경우 false 할당
    bool isOnboarded = prefs.getBool("isOnboarded") ?? false;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.getTextTheme('Jua'),
      ),
      home: isOnboarded ? HomePage() : OnboardingPage(),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: IntroductionScreen(
          pages: [
            // 페이지 1
            PageViewModel(
              title: "빠른 개발",
              body: "Flutter의 hot reload는 쉽고 UI 빌드를 도와줍니다.",
              image: Image.network(
                'https://i.ibb.co/2ZQW3Sb/flutter.png',
              ),
              decoration: PageDecoration(
                titleTextStyle: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                bodyTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            // 페이지 2
            PageViewModel(
              title: "표현력 있고 유연한 UI",
              body: "Flutter에 내장된 아름다운 위젯들로 사용자를 기쁘게 하세요.",
              image: Image.network(
                'https://i.ibb.co/LRpT3RQ/flutter2.png',
              ),
              decoration: PageDecoration(
                titleTextStyle: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                bodyTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ],
          next: Text(
            "Next1",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          done: Text(
            "Done",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          onDone: () {
            // Done 클릭 시 isOnboarded = true로 저장
            prefs.setBool("isOnboarded", true);

            // Done 클릭 시 페이지 이동
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          // 삭제 버튼
          IconButton(
            onPressed: () {
              // SharedPreferences 에 저장된 모든 데이터 삭제
              prefs.clear();
            },
            icon: Icon(
              Icons.delete,
            ),
          )
        ],
        title: Center(
          child: Text(
            "Home Page!",
          ),
        ),
      ),
      body: Center(
        child: Text(
          "환영 합니다!",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
