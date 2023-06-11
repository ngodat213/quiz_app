import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:quiz_app/themes/color.dart';
import 'package:quiz_app/themes/txt_style.dart';
import 'package:quiz_app/widget/base_text.dart';
import 'package:quiz_app/widget/quiz_card.dart';

import 'package:flutter/services.dart' as rootBundle;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Quiz> quizs = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    List<Quiz> quiz = await getDataJson();
    setState(() {
      quizs = quiz;
    });
  }

  Future<List<Quiz>> getDataJson() async {
    final jsondata =
        await rootBundle.rootBundle.loadString("lib/json/quiz.json");
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => Quiz.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(quizs: quizs),
    );
  }
}

class _buildContent extends StatefulWidget {
  const _buildContent({
    super.key,
    required this.quizs,
  });

  final List<Quiz> quizs;

  @override
  State<_buildContent> createState() => _buildContentState();
}

class _buildContentState extends State<_buildContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 223,
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
                  margin: EdgeInsets.symmetric(horizontal: 31, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _header(),
                      SizedBox(height: 16),
                      BaseText(
                        'Hello, James',
                        style: TxtStyle.font14(AppColors.background),
                      ),
                      SizedBox(height: 8),
                      BaseText(
                        'Let\'s test your knowledge',
                        style: TxtStyle.font20(AppColors.background),
                      ),
                      SizedBox(height: 16),
                      _searchTextField(),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            color: AppColors.background,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: TabBar(
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: AppColors.titleActive,
                      isScrollable: true,
                      unselectedLabelStyle: TxtStyle.font14(
                        AppColors.placeholder,
                      ),
                      indicator: BoxDecoration(gradient: AppColors.myGradient),
                      indicatorWeight: 1,
                      indicatorPadding: EdgeInsets.only(top: 45),
                      tabs: [
                        Tab(text: 'Popular'),
                        Tab(text: 'Science'),
                        Tab(text: 'Mathematic'),
                        Tab(text: 'Computer'),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(
                      'Quiz',
                      style: TxtStyle.font18(AppColors.line),
                    ),
                  ),
                  ListView.builder(
                    itemCount: widget.quizs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return QuizCard(quiz: widget.quizs[index]);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(
                      'Continue Quiz',
                      style: TxtStyle.font18(AppColors.line),
                    ),
                  ),
                  SizedBox(height: 36),
                ],
              ),
            ),
          ),
        ),
      ],
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
        SvgPicture.asset('res/icons/menu.svg'),
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

class _searchTextField extends StatelessWidget {
  const _searchTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: AppColors.label,
            fontSize: 14,
          ),
          prefixIcon: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'res/icons/search.svg',
              color: Color(0xff3550DC),
              width: 20,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'res/icons/filter.svg',
              color: Color(0xff3550DC),
              width: 20,
            ),
          ),
        ),
      ),
    );
  }
}
