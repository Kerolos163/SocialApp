import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../Social_Layout.dart';
import '../../imp_func.dart';
import '../../widgets/botton.dart';
import '../../widgets/text_field.dart';
import 'Cubit/cubit.dart';
import 'Cubit/state.dart';

class Social_signup_Screen extends StatelessWidget {
  var f_name = TextEditingController();
  var l_name = TextEditingController();
  var email = TextEditingController();
  var user_pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SignUpCubit(),
        child: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SocialCreateUserSuccState) {
              go_toAnd_finish(context, const Social_layout());
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
                      children: [
                        TEXTFIELD(
                            f_name,
                            TextInputType.emailAddress,
                            "First Name",
                            "please enter Your First Name",
                            const Icon(Icons.email),
                            false),
                        TEXTFIELD(
                            l_name,
                            TextInputType.emailAddress,
                            "Last Name",
                            "please enter Your Last Name",
                            const Icon(Icons.email),
                            false),
                        TEXTFIELD(
                            email,
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
                              icon: !SignUpCubit.get(context).vis_pass
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              onPressed: () {
                                SignUpCubit.get(context).change_vis();
                              },
                            ),
                            !SignUpCubit.get(context).vis_pass),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) {
                            return Mybutton(
                              label: "Register",
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  SignUpCubit.get(context).UserRegister(
                                      Fname: f_name.text,
                                      Lname: l_name.text,
                                      email: email.text,
                                      pass: user_pass.text);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );
                                }
                              },
                            );
                          },
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        )
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
