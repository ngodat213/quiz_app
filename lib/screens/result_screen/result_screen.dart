import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_app/models/lesson.dart';
import 'package:quiz_app/screens/home_screen/home_screen.dart';
import 'package:quiz_app/screens/check_answer/check_answer.dart';
import 'package:quiz_app/themes/colors.dart';
import 'package:quiz_app/themes/images.dart';
import 'package:quiz_app/themes/txt_styles.dart';
import 'package:quiz_app/utils/base_navigation.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    super.key,
    required this.lesson,
    required this.userChooice,
  });
  final Lesson lesson;
  final List<int> userChooice;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    for (int i = 0; i < widget.lesson.questions!.length; i++) {
      if (widget.userChooice[i] == widget.lesson.questions![i].answer) {
        res[i] = true;
        correct++;
      }
    }
    double percentage = correct / widget.lesson.questions!.length * 100;
    type = setType(percentage);
    super.initState();
  }

  String setType(double percentage) {
    if (percentage >= 90) {
      return 'GIỎI';
    } else if (percentage >= 70) {
      return 'KHÁ';
    } else if (percentage >= 50) {
      return 'TRUNG BÌNH';
    } else {
      return 'YẾU';
    }
  }

  String type = '';
  int correct = 0;
  late final List<bool> res =
      List.filled(widget.lesson.questions!.length, false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 88,
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: Center(
                    child: Container(
                      width: 48,
                      height: 4,
                      decoration: BoxDecoration(
                        gradient: AppColors.myGradient,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(gradient: AppColors.myGradient),
                child: SafeArea(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _header(lesson: widget.lesson),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 16),
                Container(
                  color: AppColors.background,
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 8),
                            _textResult(
                              'TOTAL QUESTIONS',
                              result: '${widget.lesson.questions!.length}',
                            ),
                            _textResult(
                              'SCORE',
                              result: '${correct * widget.lesson.totalPoint!}',
                            ),
                            _textResult(
                              'CORRECT ANSWER',
                              result:
                                  '$correct/${widget.lesson.questions!.length}',
                            ),
                            _textResult(
                              'INCORRECT ANSWER',
                              result: type,
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _customButton(
                                  'Go home',
                                  onTap: () {
                                    print('hello');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen(),
                                      ),
                                    );
                                  },
                                ),
                                _customButton(
                                  'Check Answer',
                                  onTap: () {
                                    print('hello');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CheckAnswer(
                                          quiz: widget.lesson,
                                          userChooice: widget.userChooice,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 150)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _customButton extends StatelessWidget {
  const _customButton(
    this.text, {
    this.onTap,
  });

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.body,
          boxShadow: [AppColors.myShadow],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(text, style: TxtStyle.font16(AppColors.background)),
      ),
    );
  }
}

class _textResult extends StatelessWidget {
  const _textResult(
    this.text, {
    required this.result,
  });
  final String text;
  final String result;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 48,
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: AppColors.body),
        boxShadow: [AppColors.myShadow],
        color: AppColors.background,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TxtStyle.font14(AppColors.titleActive)),
          Text(result, style: TxtStyle.font16(AppColors.body)),
        ],
      ),
    );
  }
}

class _header extends StatelessWidget {
  const _header({
    required this.lesson,
  });

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                BaseNavigation.pop(context);
              },
              child: SvgPicture.asset(Images.iconBackArrow),
            ),
            SizedBox(width: 16),
            Text(
              lesson.name ?? "",
              style: TxtStyle.font18(AppColors.background),
            ),
          ],
        ),
      ],
    );
  }
}
