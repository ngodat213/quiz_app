import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:quiz_app/screens/detail_screen/detail_screen.dart';
import 'package:quiz_app/themes/color.dart';
import 'package:quiz_app/themes/txt_style.dart';
import 'package:quiz_app/widget/text_icon.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({
    super.key,
    required this.quiz,
  });

  final Quiz quiz;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(quiz: quiz)),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        padding: EdgeInsets.symmetric(horizontal: 23, vertical: 12),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(color: AppColors.footer),
                  margin: EdgeInsets.only(right: 16),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quiz.name ?? "",
                      style: TxtStyle.font16(AppColors.body),
                    ),
                    SizedBox(height: 8),
                    TextIcon(
                      '${quiz.questions?.length} Question',
                      prefix: SvgPicture.asset('res/icons/note.svg'),
                    ),
                    SizedBox(height: 4),
                    TextIcon(
                      '1 hour 15 min',
                      prefix: SvgPicture.asset('res/icons/clock.svg'),
                    ),
                  ],
                )
              ],
            ),
            Positioned(
              right: 4,
              top: 0,
              bottom: 0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('res/icons/star.svg'),
                  SizedBox(width: 4),
                  Text('${quiz.rating}')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
