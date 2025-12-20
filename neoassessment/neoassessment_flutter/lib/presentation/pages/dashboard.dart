import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/sharedPref.dart';
import '../widgets/navbar/navbar_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    var userdata = (Prefs.getUser());

    var data = jsonDecode(userdata!);
    Map<String, dynamic> userObject = data["user"];
    print(userObject["first_name"] + userObject["last_name"]);
    return Container(
        color: Color.fromRGBO(244, 244, 244, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 40),
              child: Text(
                'Hi,${userObject["first_name"]}  ${userObject["last_name"]}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 40),
              child: Text(
                'Welcome Back 👋 ',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 20),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30, top: 20, bottom: 20),
                        child: Text("DashBoard",
                            style: Theme.of(context).textTheme.headlineSmall),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromRGBO(251, 238, 218, 1),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.18,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Padding(

                                  padding: const EdgeInsets.only(left: 20.0,top:25.0),
                                  child: InkWell(
                                    onTap:  (){
                                     // widget.pageController?.jumpToPage(1);
                                      //BlocProvider.of<NavbarBloc>(context).add(NavbarInitEvent(1));
                                        },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor: Color.fromRGBO(255, 155, 0, 1),
                                          child: Icon(Icons.dashboard_outlined,color: Colors.white,),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0,top:10),
                                          child: Text("5",style: Theme.of(context).textTheme.headlineMedium,),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0,top:10),
                                          child: Text("Total Domain",style: Theme.of(context).textTheme.bodyLarge,),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromRGBO(225, 249, 235, 1),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.18,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child:Padding(

                                  padding: const EdgeInsets.only(left: 20.0,top:25.0),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.pushReplacementNamed(context, '/exam');
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor: Color.fromRGBO(56, 155, 97, 1),
                                          child: Icon(Icons.question_mark_outlined,color: Colors.white,),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0,top:10),
                                          child: Text("2",style: Theme.of(context).textTheme.headlineMedium,),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0,top:10),
                                          child: Text("Total Quiz",style: Theme.of(context).textTheme.bodyLarge,),
                                        ),

                                      ],
                                    ),
                                  ),
                                )
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromRGBO(255, 234, 245, 1),
                              ),
                              height: MediaQuery.of(context).size.height * 0.18,
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Padding(

                                padding: const EdgeInsets.only(left: 20.0,top:25.0),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.pushReplacementNamed(context, "/user");
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor: Color.fromRGBO(255, 119, 119, 1),
                                        child: Icon(Icons.account_circle_outlined,color: Colors.white,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0,top:10),
                                        child: Text("6",style: Theme.of(context).textTheme.headlineMedium,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0,top:10),
                                        child: Text("Total Staff",style: Theme.of(context).textTheme.bodyLarge,),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            )
                          ]),
                    ],
                  )),
            ),
          ],
        ));
  }
}
