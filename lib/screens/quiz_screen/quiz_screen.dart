// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:quiz_app/themes/color.dart';
import 'package:quiz_app/themes/txt_style.dart';
import 'package:quiz_app/utils/base_navigation.dart';
import 'package:quiz_app/widget/base_text.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildContent(),
          _btnSubmitQuiz(),
        ],
      ),
    );
  }
}

class _buildContent extends StatelessWidget {
  const _buildContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                      _header(),
                      SizedBox(height: 54),
                      _detailQuiz(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: _detailContent(),
        ),
      ],
    );
  }
}

class _detailQuiz extends StatelessWidget {
  const _detailQuiz({
    super.key,
  });

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
                'UI UX Design Quiz',
                style: TxtStyle.font18(AppColors.background),
              ),
              BaseText(
                'GET 100 Points',
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
                '4.8',
                style: TxtStyle.font18(AppColors.background),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _detailContent extends StatelessWidget {
  const _detailContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What is the meaning of UI UX Design ?',
              style: TxtStyle.font16(AppColors.line),
            ),
            SizedBox(height: 27),
            _chooseAsswer(
              choose: 'A',
              text: 'User Interfoce and User Experience',
            ),
            _chooseAsswer(
              choose: 'B',
              text: 'User Interfoce and User Experience',
            ),
            _chooseAsswer(
              choose: 'C',
              text: 'User Interfoce and User Experience',
            ),
            _chooseAsswer(
              choose: 'D',
              text: 'User Interfoce and User Experience',
            )
          ],
        ),
      ),
    );
  }
}

class _chooseAsswer extends StatelessWidget {
  _chooseAsswer({
    Key? key,
    required this.choose,
    required this.text,
    this.isChoose = false,
  }) : super(key: key);

  final String? choose;
  final String? text;
  final bool isChoose;
  @override
  Widget build(BuildContext context) {
    final LinearGradient notChoose =
        LinearGradient(colors: [AppColors.label, AppColors.label]);
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          GestureDetector(
            child: Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  gradient: isChoose ? AppColors.myGradient : notChoose,
                  borderRadius: BorderRadius.circular(100)),
              child: Text(
                choose!.toUpperCase(),
                style: TxtStyle.font18(
                  AppColors.background,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          BaseText(
            text ?? "",
            style: TxtStyle.font13(
              AppColors.line,
            ),
          )
        ],
      ),
    );
  }
}

class _btnSubmitQuiz extends StatelessWidget {
  const _btnSubmitQuiz({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        margin: EdgeInsets.symmetric(horizontal: 24),
        color: AppColors.background,
        child: Row(
          children: [
            GestureDetector(
              child: Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: AppColors.myGradient,
                    borderRadius: BorderRadius.circular(100)),
                child: SvgPicture.asset('res/icons/previous.svg'),
              ),
            ),
            GestureDetector(
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 180,
                margin: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.body),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'Start Quiz',
                  style: TxtStyle.font16(AppColors.body),
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: AppColors.myGradient,
                    borderRadius: BorderRadius.circular(100)),
                child: SvgPicture.asset('res/icons/next.svg'),
              ),
            ),
          ],
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
        Row(
          children: [
            GestureDetector(
              onTap: () {
                BaseNavigation.pop(context);
              },
              child: SvgPicture.asset('res/icons/back_arrow.svg'),
            ),
            SizedBox(width: 16),
            Text(
              'UI UX Design Quiz',
              style: TxtStyle.font18(AppColors.background),
            ),
          ],
        ),
        Container(
          width: 77,
          height: 24,
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(100),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset('res/icons/clock.svg'),
              Text('16:35'),
            ],
          ),
        )
      ],
    );
  }
}
