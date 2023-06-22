import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_app/generated/l10n.dart';
import 'package:quiz_app/models/lesson.dart';
import 'package:quiz_app/themes/colors.dart';
import 'package:quiz_app/themes/images.dart';
import 'package:quiz_app/themes/txt_styles.dart';
import 'package:quiz_app/widget/text_icon.dart';

class ContinueCard extends StatelessWidget {
  const ContinueCard({
    super.key,
    required this.quiz,
  });
  final Lesson quiz;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                width: 112,
                height: 112,
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
                    '${quiz.questions?.length} ${S.current.question}',
                    prefix: SvgPicture.asset(Images.iconNote),
                  ),
                  SizedBox(height: 4),
                  TextIcon(
                    '1 ${S.current.hour} 15 ${S.current.min}',
                    prefix: SvgPicture.asset(Images.iconClock),
                  ),
                  SizedBox(height: 12),
                  GestureDetector(
                    child: Container(
                      height: 33,
                      width: 199,
                      decoration: BoxDecoration(
                        color: AppColors.line,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        S.current.continueQuiz,
                        style: TxtStyle.font12(AppColors.background),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          Positioned(
            top: 8,
            right: 16,
            child: SvgPicture.asset(Images.iconTrash),
          )
        ],
      ),
    );
  }
}
