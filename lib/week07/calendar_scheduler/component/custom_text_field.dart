import 'package:myapp/week06/calendar_scheduler/const/colors.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;
  final FormFiledSetter<String> onSaved;
  final FormFiledValidator<String> validator;

  const CustomTextField({
    required this.label,
    required this.isTime,
    required this.onSaved,
    required this.validator,

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column ( // 세로로 텍스트와 텍스트 필드 배치
    crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          
        )
      ]
    )
  }
}
