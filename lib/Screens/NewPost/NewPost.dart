import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubit/cubit.dart';
import 'package:social_app/Cubit/state.dart';

import '../../Theme/theme.dart';
import '../../imp_func.dart';
import '../Social_Layout.dart';

class Newpost extends StatelessWidget {
  var textcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialState>(
      listener: (context, state) {
        if (state is SocialCreatePostSuccessState) {
          // go_to(context, Social_layout());
        }
      },
      builder: (context, state) {
        var user = SocialAppCubit.get(context).usermodel;
        return Scaffold(
          appBar: appbar(context, t: "Create Post", act: [
            TextButton(
                onPressed: () {
                  if (SocialAppCubit.get(context).postImage == null) {
                    SocialAppCubit.get(context).createpost(
                        datetime: DateTime.now().toString(),
                        text: textcontroller.text);
                  } else {
                    SocialAppCubit.get(context).Uploadpost(
                        datetime: DateTime.now().toString(),
                        text: textcontroller.text);
                  }
                },
                child: Text(
                  "Post",
                  style: Titlestyle.copyWith(color: Colors.white),
                ))
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  const SizedBox(
                    height: 10,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(user!.Image),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Expanded(
                        child: Text(
                      "Kerolos Essa",
                      style: TextStyle(height: 1.4),
                    )),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textcontroller,
                    decoration: const InputDecoration(
                        hintText: "What is in your mind ...",
                        border: InputBorder.none),
                  ),
                ),
                if (SocialAppCubit.get(context).postImage != null)
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(SocialAppCubit.get(context)
                                    .postImage as File))),
                      ),
                      IconButton(
                          onPressed: () {
                            SocialAppCubit.get(context).remove_postImage();
                          },
                          icon: const CircleAvatar(
                            radius: 14,
                            child: Icon(
                              Icons.close,
                              size: 20,
                            ),
                          ))
                    ],
                  ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            SocialAppCubit.get(context).getpostimage();
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.image),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Add Photos")
                            ],
                          )),
                    ),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text("# Tags"))),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
