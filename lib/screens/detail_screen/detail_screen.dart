import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:quiz_app/screens/quiz_screen/quiz_screen.dart';
import 'package:quiz_app/themes/color.dart';
import 'package:quiz_app/themes/txt_style.dart';
import 'package:quiz_app/widget/base_text.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.quiz});
  final Quiz quiz;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildContent(quiz: widget.quiz),
          _btnStartQuiz(quiz: widget.quiz),
        ],
      ),
    );
  }
}

class _buildContent extends StatelessWidget {
  const _buildContent({
    super.key,
    required this.quiz,
  });

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 200,
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
                      _header(),
                      SizedBox(height: 54),
                      _detailQuiz(quiz: quiz),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: _detailContent(quiz: quiz),
        ),
      ],
    );
  }
}

class _detailContent extends StatelessWidget {
  const _detailContent({
    super.key,
    required this.quiz,
  });
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Brief explanation about this quiz',
              style: TxtStyle.font16(AppColors.line),
            ),
            SizedBox(height: 16),
            _iconText(
              text: '${quiz.questions!.length} Question',
              title: '${quiz.totalPoint} point for a correct answer',
              prefix: SvgPicture.asset('res/icons/note.svg'),
            ),
            SizedBox(height: 16),
            _iconText(
              text: '${quiz.totalHour} hour ${quiz.totalMin} min',
              title: 'Total duration of the quiz',
              prefix: SvgPicture.asset('res/icons/clock.svg'),
            ),
            SizedBox(height: 16),
            _iconText(
              text: 'Win 10 star',
              title: 'Answer all questions correctly',
              prefix: SvgPicture.asset('res/icons/note.svg'),
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
    );
  }
}

class _dotText extends StatelessWidget {
  const _dotText(
    this.text, {
    super.key,
  });
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
    super.key,
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
    super.key,
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
                "GET ${(quiz.totalPoint! * quiz.questions!.length).toString()} Point",
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
              SvgPicture.asset('res/icons/star.svg'),
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
    super.key,
    required this.quiz,
  });
  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        padding: EdgeInsets.only(top: 16),
        margin: EdgeInsets.symmetric(horizontal: 24),
        color: AppColors.background,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuizScreen(quiz: quiz)),
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
  const _header({
    super.key,
  });

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
