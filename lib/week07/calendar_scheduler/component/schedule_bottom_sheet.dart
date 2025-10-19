class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey(); // 폼 key 생성

  int? startTime; // 시작 시간 저장 변수
  int? endTime; // 종료 시간 저장 변수
  String? content; // 일정 내용 저장 변수

   @override
   Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Form( // 텍스트 필드를 한 번에 관리할 수 있는 폼
      key: formKey, // Form을 조작할 키값
      child: SafeArea(
        child: Container(
          
        )
      )
    )
   }
}