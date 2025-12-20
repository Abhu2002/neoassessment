import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/presentation/pages/candidate/candidates.dart';
import 'package:neoassessment_flutter/presentation/pages/changepassword.dart';
import 'package:neoassessment_flutter/presentation/pages/dashboard.dart';
import 'package:neoassessment_flutter/presentation/pages/exam/create_exam_screen.dart';
import 'package:neoassessment_flutter/presentation/pages/exam/examList.dart';
import 'package:neoassessment_flutter/presentation/pages/level/level_screen.dart';
import 'package:neoassessment_flutter/presentation/pages/question/question.dart';
import 'package:neoassessment_flutter/presentation/pages/questionCat/questionCat_screen.dart';
import 'package:neoassessment_flutter/presentation/pages/response/responses.dart';
import 'package:neoassessment_flutter/presentation/pages/role/roles.dart';
import 'package:neoassessment_flutter/presentation/pages/status/status_screen.dart';
import 'package:neoassessment_flutter/presentation/pages/users/users.dart';
import 'package:neoassessment_flutter/presentation/widgets/appbar.dart';
import 'package:neoassessment_flutter/presentation/widgets/navbar/navbar.dart';
import 'package:neoassessment_flutter/presentation/widgets/navbar/navbar_bloc.dart';

import '../../core/utils/sharedPref.dart';
import 'domain/domain_screen.dart';
import 'exam/assign_exam_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  List<Widget> adminPage = [
    DashboardScreen(),
    const DomainScreen(),
    const QuestionScreen(),
    const QuestionCategoryScreen(),
    const CreateExamScreen(),
    const ExamListScreen(),
    const UserScreen(),
    const RolesScreen(),
    const LevelScreen(),
    const ChangePasswordScreen(),
    const CandidateScreen(),
    const AssignExamScreen(),
    const Responses(),
    const StatusScreen(),
  ];

  List<Widget> candidatePage = [
    DashboardScreen(),
    const ChangePasswordScreen(),
  ];
  String? token;

  @override
  void initState() {
    token = Prefs.getAccessToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var userdata = (Prefs.getUser());
    var data = jsonDecode(userdata!);
    String  usertype = data["user_type"];
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        //   drawer: NavBar(pageController),
        appBar: const CustomAppBar(),
        body: SafeArea(
            child: CustomScrollView(slivers: [
              SliverFillRemaining(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(flex: 1, child: NavBar(pageController)),
                    Expanded(
                        flex: 7,
                        child: BlocConsumer<NavbarBloc, NavbarState>(
                          builder: (context, state) {
                            return PageView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: pageController,
                              children: usertype == "candidate"? candidatePage :adminPage,
                            );
                          },
                          listener: (BuildContext context, NavbarState state) {
                            if (state is NavbarLoaded) {
                              // pageController.jumpToPage(state.index);
                            }
                          },
                        ))
                  ],
                ),
              )
            ])),
      ),
    );
  }
}
