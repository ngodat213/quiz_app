import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/models/lesson.dart';
import 'package:quiz_app/screens/home_screen/home_screen.dart';
import 'package:quiz_app/themes/colors.dart';
import 'package:quiz_app/themes/images.dart';
import 'package:quiz_app/themes/txt_styles.dart';
import 'package:quiz_app/utils/base_navigation.dart';

class CheckAnswer extends StatefulWidget {
  const CheckAnswer({
    super.key,
    required this.lesson,
    required this.userChooice,
  });
  final Lesson lesson;
  final List<int> userChooice;

  @override
  State<CheckAnswer> createState() => _CheckAnswerState();
}

int numQuestion = 0;

class _CheckAnswerState extends State<CheckAnswer> {
  late List<bool> result = List.filled(widget.lesson.questions!.length, false);
  @override
  void initState() {
    super.initState();
    numQuestion = 0;
    for (int i = 0; i < widget.lesson.questions!.length; i++) {
      bool res = widget.userChooice[i] == widget.lesson.questions![i].answer;
      result[i] = res;
    }
  }

  Future<Map> loadBrand(String imageName) async {
    Map files = new Map();
    final Reference file = FirebaseStorage.instance.ref('quiz/$imageName');
    final String fileUrl = await file.getDownloadURL();
    files["url"] = fileUrl;
    files["path"] = file.fullPath;
    print(files);
    return files;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> option = ['A', 'B', 'C', 'D'];
    print(widget.userChooice.toString());
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
                            _header(quiz: widget.lesson),
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
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                numQuestion = i;
                              });
                            },
                            child: Container(
                              width: 32,
                              height: 32,
                              margin: EdgeInsets.only(left: 8, bottom: 6),
                              decoration: BoxDecoration(
                                color: result[i] ? Colors.green : Colors.red,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                (i + 1).toString(),
                                style: TxtStyle.font16(AppColors.border),
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
                              "Question  ${numQuestion + 1}: ${widget.lesson.questions![numQuestion].question ?? ""}",
                              style: TxtStyle.font16(AppColors.line),
                            ),
                            if (widget.lesson.questions![numQuestion].image !=
                                null)
                              FutureBuilder(
                                future: loadBrand(widget
                                    .lesson.questions![numQuestion].image!),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Container();
                                  }
                                  return Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Image.network(snapshot.data!['url']),
                                  );
                                },
                              ),
                            ListView.builder(
                              itemCount: widget.lesson.questions![numQuestion]
                                  .options?.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final Question quesN =
                                    widget.lesson.questions![numQuestion];
                                print(quesN.answer);
                                return _chooseAsswer(
                                  choose: option[index],
                                  text: quesN.options![index],
                                  isAnswer: index == quesN.answer,
                                  userChoice:
                                      widget.userChooice[numQuestion] != index,
                                );
                              },
                            ),
                            SizedBox(height: 250)
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
                MaterialPageRoute(builder: (context) => HomeScreen()),
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
    this.isAnswer,
    this.userChoice,
  }) : super(key: key);

  final bool? userChoice;
  final String? choose;
  final String? text;
  final bool? isAnswer;
  @override
  Widget build(BuildContext context) {
    final LinearGradient notChoose =
        LinearGradient(colors: [AppColors.label, AppColors.label]);
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: isAnswer! ? AppColors.trueAswer : notChoose,
                borderRadius: BorderRadius.circular(100)),
            child: Text(
              choose!.toUpperCase(),
              style: TxtStyle.font18(
                AppColors.background,
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
                  'Go Home',
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
    required this.quiz,
  });

  final Lesson quiz;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                BaseNavigation.pop(context);
              },
              child: SvgPicture.asset(Images.iconBackArrow),
            ),
            SizedBox(width: 16),
            Text(
              "Check Answer",
              style: TxtStyle.font18(AppColors.background),
            ),
          ],
        ),
      ],
    );
  }
}
