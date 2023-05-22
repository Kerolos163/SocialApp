import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../Shared_Pref/Share_Pref.dart';
import '../SignUpScreen/signup.dart';
import '../Social_Layout.dart';
import '../../imp_func.dart';
import '../../widgets/botton.dart';
import '../../widgets/text_field.dart';
import 'Cubit/cubit.dart';
import 'Cubit/state.dart';

class Social_login_Screen extends StatelessWidget {
  var user_name = TextEditingController();
  var user_pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is SocialRegisterErrorState) {
              print(state.error);
              print("wessooooooooooooooooooooooooooooooo");
            }
            if (state is SocialRegisterSuccState) {
              Sharepref.savedata(key: "U_ID", value: state.User_ID)
                  .then((value) {
                    go_toAnd_finish(context,const Social_layout());
              });
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.blue,
                    Colors.red,
                  ],
                )),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TEXTFIELD(
                            user_name,
                            TextInputType.emailAddress,
                            "Emil",
                            "please enter Your Emil",
                            const Icon(Icons.email),
                            false),
                        const SizedBox(
                          height: 10,
                        ),
                        TEXTFIELD(
                            user_pass,
                            TextInputType.text,
                            "password",
                            "please enter Your password",
                            IconButton(
                              icon: !LoginCubit.get(context).vis_pass
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              onPressed: () {
                                LoginCubit.get(context).change_vis();
                              },
                            ),
                            !LoginCubit.get(context).vis_pass),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) {
                            return Mybutton(
                              label: "LogIn",
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: user_name.text,
                                      pass: user_pass.text);

                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing LogIn')),
                                  );
                                }
                              },
                            );
                          },
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        TextButton(
                            onPressed: () {
                              go_to(context, Social_signup_Screen());
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(color: Colors.black),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
