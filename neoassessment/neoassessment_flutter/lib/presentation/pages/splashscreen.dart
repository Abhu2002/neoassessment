import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/sharedPref.dart';
import '../bloc/users/remote_users_bloc.dart';
import '../bloc/users/remote_users_event.dart';
import '../bloc/users/remote_users_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? token;

  startTimer() {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void initState() {
    token = Prefs.getAccessToken();

    if (token == null) {
      startTimer();
    } else {
      BlocProvider.of<RemoteUsersBloc>(context).add(
        VerifyTokenEvent(token!),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(144, 70, 110, 90),
              Colors.lightGreenAccent
            ]),
      ),
      child: Center(
        child: BlocConsumer<RemoteUsersBloc, RemoteUsersState>(
          builder: (BuildContext context, RemoteUsersState state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 200,
                    height: 150,
                    child: Image.asset('assets/images/splash_logo.png')),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("NeoAssessment",
                      style: Theme.of(context).textTheme.displayLarge),
                )
              ],
            );
          },
          listener: (BuildContext context, RemoteUsersState state) {
            if (state is VerifyTokenDone) {
              var userId = state.data[1]['user_id'];
              print(state.data);
              if (userId != null) {
                Navigator.pushReplacementNamed(context, '/baseScreen');
              } else {
                // startTimer();
                Navigator.pushReplacementNamed(context, '/login');
              }
              // Navigator.pop(context);
            }
            if (state is UserErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.error),
                ),
              );
            }
          },
        ),
      ),
    ));
  }
}
