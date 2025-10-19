import 'package:flutter/gestures.dart';
import 'package:myapp/week06/calendar_scheduler/database/drift_database.dart';
import 'package:myapp/week06/calendar_scheduler/componet/today_banner.dart';

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton( // 새 일정 버튼
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          showModalBottomSheet( // BottomSheet 열기
            context: context,
            isDismissible: true, // 배경 탭 했을 때 BoottomSheet 닫기
            builder: (_) => ScheduleBottomSheet(
              selectedDate: selectedDate,
            ),
            // BottomSheet의 높이를 화면의 최대 높이로 정의하고 스크롤 가능하게 변경
          )
        }
      )
    )
  }
}