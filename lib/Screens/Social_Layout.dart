import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubit/cubit.dart';
import '../Cubit/state.dart';
import '../imp_func.dart';
import 'NewPost/NewPost.dart';

class Social_layout extends StatelessWidget {
  const Social_layout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialState>(
      listener: (context, state) {
        if(state is SocialNewPostState)
        {
          go_to(context, Newpost());
        }
      },
      builder: (context, state) {
        var cubit = SocialAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.Titles[cubit.CurrentIndex]),
            actions: [
              IconButton(onPressed: () {
                
              }, icon:const Icon(Icons.notifications)),
              IconButton(onPressed: () {
                
              }, icon:const Icon(Icons.search))
            ],
          ),
          // body: ConditionalBuilder(
          //   condition: SocialAppCubit.get(context).model != null,
          //   builder: (context) {
          //     var model = SocialAppCubit.get(context).model;
          //     return Column(
          //       children: [
          // if (!FirebaseAuth.instance.currentUser!.emailVerified)
          //   Container(
          //     height: 50,
          //     color: Colors.amber.withOpacity(.6),
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 20),
          //       child: Row(
          //         children: [
          //           const Icon(Icons.info_outline),
          //           const SizedBox(
          //             width: 10,
          //           ),
          //           const Expanded(
          //               child: Text("please Verify your Email")),
          //           const SizedBox(
          //             width: 20,
          //           ),
          //           TextButton(
          //               onPressed: () {
          //                 FirebaseAuth.instance.currentUser
          //                     ?.sendEmailVerification()
          //                     .then((value) {
          //                   Fluttertoast.showToast(
          //                       msg: "Check Your Email",
          //                       toastLength: Toast.LENGTH_SHORT,
          //                       gravity: ToastGravity.CENTER,
          //                       timeInSecForIosWeb: 1,
          //                       backgroundColor: Colors.red,
          //                       textColor: Colors.white,
          //                       fontSize: 16.0);
          //                 });
          //               },
          //               child: const Text('Send'))
          //         ],
          //       ),
          //     ),
          //   )

          //       ],
          //     );
          //   },
          //   fallback: (context) => const Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // )
          body: cubit.Screens[cubit.CurrentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.CurrentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
              BottomNavigationBarItem(icon: Icon(Icons.post_add), label: "Post"),

              BottomNavigationBarItem(
                  icon: Icon(Icons.person_pin_circle), label: "Users"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings"),
            ],
            onTap: (value) {
              cubit.ChangeBottomNav(value);
            },
            elevation: 25,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.teal,
            unselectedItemColor: Colors.grey,
          ),
        );
      },
    );
  }
}
