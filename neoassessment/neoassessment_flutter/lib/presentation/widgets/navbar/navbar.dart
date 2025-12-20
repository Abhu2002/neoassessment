import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/presentation/widgets/navbar/navbar_bloc.dart';

//import '../../../config/navigation/route_paths.dart';
import '../../../config/navigation/route_paths.dart';
import '../../../core/utils/sharedPref.dart';

class NavBar extends StatefulWidget {
  PageController pageController;

  NavBar(this.pageController, {Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index = 0;

  @override
  void initState() {
    Prefs.init;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarBloc, NavbarState>(builder: (context, state) {
      if (state is NavbarLoaded) {
        index = state.index;
      }
      List<Widget> admin = [
        DrawerListTile(
            title: "Dashboard",
            icon: const Icon(Icons.question_mark_sharp),
            isSelected: index == 0,
            press: () {
              widget.pageController.jumpToPage(0);
              BlocProvider.of<NavbarBloc>(context).add(NavbarInitEvent(0));
            }),
        DrawerListTile(
            title: "Domain",
            icon: const Icon(
              Icons.dashboard_outlined,
            ),
            isSelected: index == 1,
            press: () {
              widget.pageController.jumpToPage(1);
              BlocProvider.of<NavbarBloc>(context).add(NavbarInitEvent(1));
            }),
        ExpansionTile(
          collapsedBackgroundColor:
          ModalRoute.of(context)?.settings.name == '/question' ||
              ModalRoute.of(context)?.settings.name ==
                  '/questionCategory' ||
              ModalRoute.of(context)?.settings.name == '/exam/create'
              ? Colors.green
              : null,
          leading: const Icon(Icons.edit_note),
          title: Text("Quiz",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 23)),
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: DrawerListTile(
                title: 'Question',
                icon: const Icon(Icons.question_mark_outlined),
                isSelected: index == 2,
                press: () {
                  widget.pageController.jumpToPage(2);
                  BlocProvider.of<NavbarBloc>(context).add(NavbarInitEvent(2));
                },
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: DrawerListTile(
                title: 'Question Category',
                icon: const Icon(Icons.dashboard),
                isSelected: index == 3,
                press: () {
                  widget.pageController.jumpToPage(3);
                  BlocProvider.of<NavbarBloc>(context).add(NavbarInitEvent(3));
                },
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: DrawerListTile(
                title: 'Create Exam',
                icon: const Icon(Icons.post_add_rounded),
                isSelected: index == 4,
                press: () {
                  widget.pageController.jumpToPage(4);
                  BlocProvider.of<NavbarBloc>(context).add(NavbarInitEvent(4));
                },
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: DrawerListTile(
                title: 'Exam List',
                icon: const Icon(Icons.format_list_bulleted_sharp),
                isSelected: index == 5,
                press: () {
                  widget.pageController.jumpToPage(5);
                  BlocProvider.of<NavbarBloc>(context).add(NavbarInitEvent(5));
                },
              ),
            ),

            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: DrawerListTile(
                title: 'Assign Exam',
                icon: const Icon(Icons.playlist_add_check_sharp),
                isSelected: index == 11,
                press: () {
                  widget.pageController.jumpToPage(11);
                  BlocProvider.of<NavbarBloc>(context).add(NavbarInitEvent(11));
                },
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: DrawerListTile(
                title: 'Responses',
                icon: const Icon(Icons.analytics_sharp),
                isSelected: index == 12,
                press: () {
                  widget.pageController.jumpToPage(12);
                  BlocProvider.of<NavbarBloc>(context).add(NavbarInitEvent(12));
                },
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: DrawerListTile(
                title: 'Status',
                icon: const Icon(Icons.stairs),
                isSelected: index == 13,
                press: () {
                  widget.pageController.jumpToPage(13);
                  BlocProvider.of<NavbarBloc>(context).add(NavbarInitEvent(13));
                },
              ),
            ),
          ],
        ),
        ExpansionTile(
          collapsedBackgroundColor:
          ModalRoute.of(context)?.settings.name == '/users'
              ? Colors.green
              : null,
          leading: const Icon(Icons.people_outlined),
          title: Text("Users",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 23)),
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: DrawerListTile(
                  title: "Staff",
                  icon: const Icon(
                    Icons.person,
                  ),
                  isSelected: index == 6,
                  press: () {
                    widget.pageController.jumpToPage(6);
                    BlocProvider.of<NavbarBloc>(context)
                        .add(NavbarInitEvent(6));
                  }),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: DrawerListTile(
                  title: "Candidates",
                  icon: const Icon(
                    Icons.person,
                  ),
                  isSelected: index == 10,
                  press: () {
                    widget.pageController.jumpToPage(10);
                    BlocProvider.of<NavbarBloc>(context)
                        .add(NavbarInitEvent(10));
                  }),
            ),
          ],
        ),
        DrawerListTile(
            title: "Roles",
            icon: const Icon(
              Icons.supervisor_account,
            ),
            isSelected: index == 7,
            press: () {
              widget.pageController.jumpToPage(7);
              BlocProvider.of<NavbarBloc>(context).add(NavbarInitEvent(7));
            }),
        DrawerListTile(
            title: "Levels",
            icon: const Icon(
              Icons.stairs,
            ),
            isSelected: index == 8,
            press: () {
              widget.pageController.jumpToPage(8);
              BlocProvider.of<NavbarBloc>(context).add(NavbarInitEvent(8));
            }),
        DrawerListTile(
            title: "Change Password",
            icon: const Icon(
              Icons.key,
            ),
            isSelected: index == 9,
            press: () {
              widget.pageController.jumpToPage(8);
              // Navigator.pop(context);
              BlocProvider.of<NavbarBloc>(context).add(NavbarInitEvent(8));
              widget.pageController.jumpToPage(9);
              // Navigator.pop(context);
              BlocProvider.of<NavbarBloc>(context).add(NavbarInitEvent(9));
            }),
        DrawerListTile(
            title: "Logout",
            icon: const Icon(
              Icons.logout,
            ),
            isSelected: index == 10,
            press: () {
              Prefs.clearAllPreference();
              Navigator.pushReplacementNamed(context, RoutePaths.splashscreen);
            }),
      ];
      List<Widget> candidate = [
        DrawerListTile(
            title: "Dashboard",
            icon: const Icon(Icons.question_mark_sharp),
            isSelected: index == 0,
            press: () {
              widget.pageController.jumpToPage(0);
              BlocProvider.of<NavbarBloc>(context).add(NavbarInitEvent(0));
            }),

        DrawerListTile(
            title: "Change Password",
            icon: const Icon(
              Icons.key,
            ),
            isSelected: index == 1,
            press: () {

              widget.pageController.jumpToPage(1);
              BlocProvider.of<NavbarBloc>(context).add(NavbarInitEvent(1));
            }),
        DrawerListTile(
            title: "Logout",
            icon: const Icon(
              Icons.logout,
            ),
            isSelected: index == 10,
            press: () {
              Prefs.clearAllPreference();
              Navigator.pushReplacementNamed(context, RoutePaths.splashscreen);
            }),
      ];


      var userdata = (Prefs.getUser());
      var data = jsonDecode(userdata!);
      String usertype = data["user_type"];
      return Drawer(
          elevation: 5.0,
          width: 450,
          child: ListView(
            children: usertype == "candidate"? candidate: admin,
          ));
    });
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.press,
  }) : super(key: key);

  final String title;
  final Icon icon;
  final bool isSelected;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: (isSelected) ? const Color.fromARGB(10, 209, 234, 185) : null,
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: icon,
      title: Text(
        title,
        style:
            TextStyle(color: (isSelected) ? Colors.lightGreen : Colors.black),
      ),
    );
  }
}
