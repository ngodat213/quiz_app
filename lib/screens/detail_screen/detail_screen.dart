import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_app/models/lesson.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:quiz_app/screens/quiz_screen/quiz_screen.dart';
import 'package:quiz_app/themes/colors.dart';
import 'package:quiz_app/themes/images.dart';
import 'package:quiz_app/themes/txt_styles.dart';
import 'package:quiz_app/widget/base_text.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.quiz});
  final Quiz quiz;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Lesson chooseLesson = Lesson();
  int isSelect = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 200,
                elevation: 0,
                backgroundColor: AppColors.background,
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
                        margin:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _header(),
                            SizedBox(height: 54),
                            _detailQuiz(quiz: widget.quiz),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lesson',
                          style: TxtStyle.font16(AppColors.line),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.quiz.lessons!.length,
                          itemBuilder: (context, index) {
                            return _btnLesson(
                              widget.quiz.lessons![index].lessonName!
                                  .toString(),
                              result: widget.quiz.lessons![index].name!,
                              onTap: () {
                                setState(() {
                                  chooseLesson = widget.quiz.lessons![index];
                                  isSelect = index;
                                });
                              },
                              isSelected: isSelect == index,
                            );
                          },
                        ),
                        Text(
                          'Brief explanation about this quiz',
                          style: TxtStyle.font16(AppColors.line),
                        ),
                        SizedBox(height: 16),
                        _iconText(
                          text: '${widget.quiz.lessons!.length} Question',
                          title:
                              '${widget.quiz.getPoint} point for a correct answer',
                          prefix: SvgPicture.asset(Images.iconNote),
                        ),
                        SizedBox(height: 16),
                        _iconText(
                          text: '1 hour 0 min',
                          title: 'Total duration of the quiz',
                          prefix: SvgPicture.asset(Images.iconClock),
                        ),
                        SizedBox(height: 16),
                        _iconText(
                          text: 'Win 10 star',
                          title: 'Answer all questions correctly',
                          prefix: SvgPicture.asset(Images.iconNote),
                        ),
                        SizedBox(height: 24),
                        Text(
                          'Please read the text below carefully so you can understand it',
                          style: TxtStyle.font16(AppColors.line),
                        ),
                        _dotText(
                          '10 point awarded for a correct answer and no marks for a incorrect answer',
                        ),
                        _dotText(
                          'Tap on options to select the correct answer',
                        ),
                        _dotText(
                          'Tap on the bookmark icon to save interesting questions',
                        ),
                        _dotText(
                          'Click submit if you are sure you want to complete all the quizzes',
                        ),
                        SizedBox(height: 56),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          _btnStartQuiz(lesson: chooseLesson),
        ],
      ),
    );
  }
}

class _btnLesson extends StatelessWidget {
  const _btnLesson(
    this.text, {
    required this.result,
    required this.onTap,
    this.isSelected = false,
  });
  final String text;
  final String result;
  final VoidCallback onTap;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 48,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          border: isSelected == true
              ? Border.all(
                  width: 2,
                  color: AppColors.body,
                )
              : null,
          boxShadow: [AppColors.myShadow],
          color: AppColors.background,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Lesson $text", style: TxtStyle.font14(AppColors.titleActive)),
            Text(result, style: TxtStyle.font16(AppColors.body)),
          ],
        ),
      ),
    );
  }
}

class _dotText extends StatelessWidget {
  const _dotText(this.text);
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.line,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          SizedBox(width: 16),
          Container(
            width: MediaQuery.of(context).size.width - 70,
            child: Text(text ?? ""),
          )
        ],
      ),
    );
  }
}

class _iconText extends StatelessWidget {
  const _iconText({
    this.prefix,
    this.text,
    this.title,
  });

  final SvgPicture? prefix;
  final String? text;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: AppColors.line,
            borderRadius: BorderRadius.circular(100),
          ),
          child: prefix,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text!,
              style: TxtStyle.font16(AppColors.line),
            ),
            SizedBox(height: 3),
            Text(
              title!,
              style: TxtStyle.font14(AppColors.inputBackground),
            ),
          ],
        )
      ],
    );
  }
}

class _detailQuiz extends StatelessWidget {
  const _detailQuiz({
    required this.quiz,
  });

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                quiz.name ?? "",
                style: TxtStyle.font18(AppColors.background),
              ),
              BaseText(
                "GET ${(quiz.getPoint! * quiz.lessons!.length).toString()} Point",
                style: TxtStyle.font12(AppColors.background),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: Row(
            children: [
              SvgPicture.asset(Images.iconStar),
              SizedBox(width: 8),
              Text(
                quiz.rating.toString(),
                style: TxtStyle.font18(AppColors.background),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _btnStartQuiz extends StatelessWidget {
  const _btnStartQuiz({
    required this.lesson,
  });
  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        margin: EdgeInsets.symmetric(horizontal: 24),
        color: AppColors.background,
        child: GestureDetector(
          onTap: () {
            final Lesson random = lesson;
            lesson.questions!.shuffle(Random());
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => QuizScreen(lesson: random)),
            );
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width - 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: AppColors.myGradient,
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              'Start Quiz',
              style: TxtStyle.font16(AppColors.background),
            ),
          ),
        ),
      ),
    );
  }
}

class _header extends StatelessWidget {
  const _header();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Detail Quiz',
          style: TxtStyle.font18(AppColors.background),
        ),
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(100),
          ),
        )
      ],
    );
  }
}
