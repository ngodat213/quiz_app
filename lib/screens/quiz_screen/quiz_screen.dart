import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_app/generated/l10n.dart';
import 'package:quiz_app/models/lesson.dart';
import 'package:quiz_app/screens/result_screen/result_screen.dart';

import 'package:quiz_app/themes/colors.dart';
import 'package:quiz_app/themes/images.dart';
import 'package:quiz_app/themes/txt_styles.dart';
import 'package:quiz_app/utils/base_navigation.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.lesson});
  final Lesson lesson;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  void onUserSelect(int data) {
    setState(
      () {
        isChooseList[numQuestion] = data;
      },
    );
  }

  void updateIsChooseList(List<int> newIsChooseList) {
    setState(() {
      isChooseList = newIsChooseList;
    });
  }

  int numQuestion = 0;
  late List<int> isChooseList =
      List.filled(widget.lesson.questions!.length, -1);
  @override
  Widget build(BuildContext context) {
    print(isChooseList.toString());
    final List<String> choose = ['A', 'B', 'C', 'D'];
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 88,
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
                    Wrap(
                      children: [
                        for (int i = 0;
                            i < widget.lesson.questions!.length;
                            i++)
                          Container(
                            width: 32,
                            height: 32,
                            margin: EdgeInsets.only(left: 8, bottom: 6),
                            decoration: BoxDecoration(
                              color: isChooseList[i] == -1
                                  ? AppColors.border
                                  : AppColors.body,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              (i + 1).toString(),
                              style: TxtStyle.font16(
                                isChooseList[i] != -1
                                    ? AppColors.border
                                    : AppColors.titleActive,
                              ),
                            ),
                          )
                      ],
                    ),
                    Divider(),
                    SizedBox(height: 16),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${S.current.question}  ${numQuestion + 1}: ${widget.lesson.questions![numQuestion].question ?? ""}",
                              style: TxtStyle.font16(AppColors.line),
                            ),
                            if (widget.lesson.questions![numQuestion].image !=
                                null)
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Image.asset(widget
                                    .lesson.questions![numQuestion].image!),
                              ),
                            ListView.builder(
                              itemCount: widget.lesson.questions![numQuestion]
                                  .options?.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return _chooseAsswer(
                                  onTap: () {
                                    onUserSelect(index);
                                  },
                                  isChoose: index == isChooseList[numQuestion],
                                  choose: choose[index],
                                  text: widget.lesson.questions![numQuestion]
                                      .options![index],
                                );
                              },
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
          _btnSubmitQuiz(
            num: numQuestion,
            prefix: () {
              setState(() {
                if (numQuestion != 0) {
                  numQuestion--;
                }
              });
            },
            submit: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultScreen(
                    lesson: widget.lesson,
                    userChooice: isChooseList,
                  ),
                ),
              );
            },
            suffix: () {
              setState(() {
                if (numQuestion < widget.lesson.questions!.length - 1) {
                  numQuestion++;
                }
              });
            },
          ),
        ],
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
    required this.onTap,
  }) : super(key: key);

  final String? choose;
  final String? text;
  final VoidCallback onTap;
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
            onTap: onTap,
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
          Container(
            width: MediaQuery.of(context).size.width - 48 - 50 - 8,
            child: Text(
              text ?? "",
              style: TxtStyle.font14(
                AppColors.line,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _btnSubmitQuiz extends StatelessWidget {
  const _btnSubmitQuiz({
    this.prefix,
    this.submit,
    this.suffix,
    this.num,
  });

  final VoidCallback? prefix;
  final VoidCallback? submit;
  final VoidCallback? suffix;
  final int? num;

  @override
  Widget build(BuildContext context) {
    final LinearGradient notChoose =
        LinearGradient(colors: [AppColors.label, AppColors.label]);
    return Positioned(
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        margin: EdgeInsets.symmetric(horizontal: 24),
        color: AppColors.background,
        child: Row(
          children: [
            GestureDetector(
              onTap: prefix,
              child: Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: num != 0 ? AppColors.myGradient : notChoose,
                    borderRadius: BorderRadius.circular(100)),
                child: SvgPicture.asset(Images.iconPrevious),
              ),
            ),
            GestureDetector(
              onTap: submit,
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
                  S.current.submit,
                  style: TxtStyle.font16(AppColors.body),
                ),
              ),
            ),
            GestureDetector(
              onTap: suffix,
              child: Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: AppColors.myGradient,
                    borderRadius: BorderRadius.circular(100)),
                child: SvgPicture.asset(Images.iconNext),
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
              SvgPicture.asset(Images.iconClock),
              Text('16:35'),
            ],
          ),
        )
      ],
    );
  }
}
