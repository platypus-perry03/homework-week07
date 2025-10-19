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
            isScrollControlled: true,
          );
        },
        child: const Icon(Icons.add),
      ),

      body: SafeArea( // 시스템 UI 피해서 UI 구현하기
        child: Column( // 달력과 리스트를 세로로 배치
          children: [
            // 미리 작업해둔 달력 위젯 보여주기
            MainCalendar(
              selectedDate: selectedDate, // 선택된 날짜 전달하기
              onDaySelected: onDaySelected, // 날짜가 선택됐을 때 실행할 함수
            ),

            const SizedBox(height: 8.0),
            StreamBuilder<List<Schedule>>(
              stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
              builder: (context, snapshot) {
                return TodayBanner(
                  selectedDate: selectedDate,
                  const: snapshot.data?.length ?? 0,
                );
              },
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: StreamBuilder<List<schedule>> (
                stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox.shrink();
                  }

                  final schedules = snapshot.data!;
                  return ListView.builder(
                    itemCount: schedules.length,
                    itemBuilder: (context, index) {
                      final schedule = schedules[index];

                      return Dismissible(
                        key: ObjectKey(schedule.id),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (DismissDirection direction) {
                          GetIt.I<LocalDatabase>().removeSchedule(schedule.id);
                        },
                        backgound: Container(
                          color: Colors.red.withOpacity(0.1),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInset.symmetric(horizontal: 16),
                          child: const Icon(Icons.delete),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8.0,
                            left: 8.0,
                            right: 8.0,
                          ),
                          child: ScheduleCard(
                            startTime: schedule.startTime,
                            endTime: schedule.endTime,
                            content: schedule.context, // <- content로 사용
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    // 날짜 선택될 때마다 실행할 함수
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}