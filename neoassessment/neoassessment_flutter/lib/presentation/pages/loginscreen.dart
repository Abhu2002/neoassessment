import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/users/remote_users_bloc.dart';
import 'package:neoassessment_flutter/presentation/bloc/users/remote_users_event.dart';
import 'package:neoassessment_flutter/presentation/bloc/users/remote_users_state.dart';


enum UserType { staff, candidate }
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  int selectedOption = 1;

  @override
  void initState() {
    super.initState();
    emailTextController.text = "abra@gmail.com";
    passwordTextController.text = "12345678";
    BlocProvider.of<RemoteUsersBloc>(context).add(InitialUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    UserType? type = UserType.staff;
    return Scaffold(
      backgroundColor: Colors.white,
      body: DecoratedBox(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/login_background.jpg"),
          fit: BoxFit.fill,
        )),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.76,
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(236, 190, 220, 196)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.width * 0.01,
                              top: MediaQuery.of(context).size.width * 0.03),
                          child: Center(
                            child: SizedBox(
                                child: Image.asset('images/user_icon.png')),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.002,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.009),
                            child: Center(
                              child: Text("NeoAssessment",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                          bottom: MediaQuery.of(context).size.height * 0.02),
                      child: Center(
                        child: Text("User Login",
                            style: Theme.of(context).textTheme.bodyLarge),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: emailTextController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email id';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Email',
                          labelStyle: Theme.of(context).textTheme.bodyMedium,
                          hintText: 'Enter valid email id as abc@gmail.com',
                          hintStyle: Theme.of(context).textTheme.bodyLarge),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    child: TextFormField(
                      controller: passwordTextController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Password',
                          labelStyle: Theme.of(context).textTheme.bodyMedium,
                          hintText: 'Enter secure password',
                          hintStyle: Theme.of(context).textTheme.bodyLarge),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {

                      },
                      child: Text(
                        'Forgot Password?',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  BlocBuilder<RemoteUsersBloc,RemoteUsersState>(
                      buildWhen: (previous, current) {
                        if (current is UserTypeState) {
                          type = current.type;
                        }
                        return current is UserTypeState;
                      },
                    builder: (BuildContext  context,state) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 15,bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Radio<UserType>(
                                    value: UserType.staff,
                                    groupValue: state.type ?? type,
                                    fillColor: MaterialStateProperty.all(Colors.green),
                                    activeColor: Colors.green,
                                    onChanged: ( value) {
                                      BlocProvider.of<RemoteUsersBloc>(context)
                                          .add(UserTypeEvent(value!));
                                    }),
                                const Text(
                                  'Staff',
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Radio<UserType>(
                                    value: UserType.candidate,
                                    groupValue:state.type ?? type,
                                    fillColor: MaterialStateProperty.all(Colors.lightGreen),
                                    activeColor: Colors.lightGreen,
                                    onChanged: (value) {
                                      BlocProvider.of<RemoteUsersBloc>(context)
                                          .add(UserTypeEvent(value!));
                                    }),
                                const Text('Candidate')
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                  BlocConsumer<RemoteUsersBloc, RemoteUsersState>(
                    builder: (context, state) {
                      return Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.385,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20)),
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (type?.name =='candidate'){
                                BlocProvider.of<RemoteUsersBloc>(context).add(
                                  LoginUserCandidateEvent(
                                    emailTextController.text,
                                    passwordTextController.text,
                                  ),
                                );
                              }
                              else{
                                BlocProvider.of<RemoteUsersBloc>(context).add(
                                  LoginUserEvent(
                                    emailTextController.text,
                                    passwordTextController.text,
                                  ),
                                );
                              }
                            }
                          },
                          child: Text(
                            'Login',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      );
                    },
                    listener: (context, state) {
                      if (type?.name =="staff"){

                        if (state is UserErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(state.error),
                            ),
                          );
                        }
                      }
                      else{
                          if (state is CandidateUserErrorState){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error),backgroundColor: Colors.green,)
                            );
                          }
                        }
                      if (type?.name == "staff"){
                        if (state is LoginUserState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(state.message),
                            ),
                          );
                          Navigator.pushReplacementNamed(context, '/baseScreen');
                        }
                      } else {
                        if (state is LoginUserCandidateState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(state.message),
                            ),
                          );
                          Navigator.pushReplacementNamed(context, '/baseScreen');
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
