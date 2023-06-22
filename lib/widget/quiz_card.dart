import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_app/generated/l10n.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:quiz_app/screens/detail_screen/detail_screen.dart';
import 'package:quiz_app/themes/colors.dart';
import 'package:quiz_app/themes/images.dart';
import 'package:quiz_app/themes/txt_styles.dart';
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
                    Container(
                      width: MediaQuery.of(context).size.width - 182,
                      child: Text(
                        quiz.name ?? "",
                        style: TxtStyle.font16(AppColors.body),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextIcon(
                      '${quiz.lessons!.length} ${S.current.lesson}',
                      prefix: SvgPicture.asset(Images.iconNote),
                    ),
                    SizedBox(height: 4),
                    TextIcon(
                      '1 ${S.current.hour} 15 ${S.current.min}',
                      prefix: SvgPicture.asset(Images.iconClock),
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
                  SvgPicture.asset(Images.iconStar),
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
