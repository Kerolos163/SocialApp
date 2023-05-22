import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubit/cubit.dart';
import 'package:social_app/Cubit/state.dart';

import '../../Theme/theme.dart';
import '../../imp_func.dart';
import '../../model/Social.dart';
import '../../model/messagemodel.dart';

class ChatDetailScreen extends StatelessWidget {
  Social_model usermodel;
  ChatDetailScreen(this.usermodel);
  var messagecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialAppCubit.get(context).GetMessage(receiverId: usermodel.Uid);
        return BlocConsumer<SocialAppCubit, SocialState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0,
                  title: Row(children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(usermodel.Image),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text('${usermodel.Fname} ${usermodel.Lname}')
                  ]),
                  leading: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                ),
                body: ConditionalBuilder(
                  condition: SocialAppCubit.get(context).Message.isNotEmpty,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var message = SocialAppCubit.get(context)
                                      .Message[index];
                                  if (SocialAppCubit.get(context)
                                          .usermodel!
                                          .Uid ==
                                      message.senderid) {
                                    return BuildMyMessage(message, context);
                                  }
                                  return BuildMessage(message, context);
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 15,
                                    ),
                                itemCount:
                                    SocialAppCubit.get(context).Message.length),
                          ),
                          if (SocialAppCubit.get(context).SendImg != null)
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
                                          image: FileImage(
                                              SocialAppCubit.get(context)
                                                  .SendImg as File))),
                                ),
                                IconButton(
                                    onPressed: () {
                                      SocialAppCubit.get(context)
                                          .remove_SendImage();
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
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding:const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: messagecontroller,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Message ...'),
                                    ),
                                  ),
                                  IconButton(
                                      padding: const EdgeInsets.all(2),
                                      onPressed: () {
                                        SocialAppCubit.get(context)
                                            .GetSendimage();
                                      },
                                      icon: const Icon(
                                        Icons.image,
                                        size: 25,
                                        color: primaryClr,
                                      )),
                                  IconButton(
                                      padding: const EdgeInsets.all(2),
                                      onPressed: () {
                                        if (SocialAppCubit.get(context)
                                                .SendImg ==
                                            null) {
                                          SocialAppCubit.get(context)
                                              .SendMessage(
                                                  receiverId: usermodel.Uid,
                                                  DateTime:
                                                      DateTime.now().toString(),
                                                  text: messagecontroller.text);

                                          // if(SocialAppCubit.get(context).SendImg!=null)
                                          // {
                                          //   SocialAppCubit.get(context).uploadimag();
                                          // }
                                        } else {
                                          SocialAppCubit.get(context)
                                              .uploadimag(
                                                  receiverId: usermodel.Uid,
                                                  DateTime:
                                                      DateTime.now().toString(),
                                                  text: messagecontroller.text);
                                        }
                                        messagecontroller.text = "";
                                        SocialAppCubit.get(context)
                                            .remove_SendImage();
                                      },
                                      icon: const CircleAvatar(
                                          radius: 20,
                                          backgroundColor: primaryClr,
                                          child: Icon(
                                            Icons.send,
                                            size: 22,
                                          )))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator()),
                ));
          },
        );
      },
    );
  }

  Widget BuildMessage(messagemodel model, context) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (model.text != "")
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadiusDirectional.only(
                      topStart: Radius.circular(10),
                      topEnd: Radius.circular(10),
                      bottomEnd: Radius.circular(10),
                    )),
                child: Text(
                  model.text as String,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            if (model.Image != null)
              const SizedBox(
                height: 5,
              ),
            if (model.Image != "")
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: NetworkImage(
                      model.Image as String,
                    ),
                    width: mediaquery(context).width / 2,
                  ),
                ),
              )
          ],
        ),
      );

  Widget BuildMyMessage(messagemodel model, context) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (model.text != "")
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    color: primaryClr.withOpacity(.2),
                    borderRadius: const BorderRadiusDirectional.only(
                      topStart: Radius.circular(10),
                      topEnd: Radius.circular(10),
                      bottomStart: Radius.circular(10),
                    )),
                child: Text(
                  model.text as String,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            if (model.Image != null)
              const SizedBox(
                height: 5,
              ),
            if (model.Image != "")
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: NetworkImage(
                      model.Image as String,
                    ),
                    width: mediaquery(context).width / 2,
                  ),
                ),
              )
          ],
        ),
      );
}
