import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Screens/Edit_profile/Edit.dart';
import 'package:social_app/imp_func.dart';

import '../../Cubit/cubit.dart';
import '../../Cubit/state.dart';
import '../../Theme/theme.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var usermodel = SocialAppCubit.get(context).usermodel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage('${usermodel?.cover}'))),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage('${usermodel?.Image}'),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${usermodel?.Fname} ${usermodel?.Lname}',
                style: Titlestyle,
              ),
              Text(
                '${usermodel?.Bio}',
                style: Body2lestyle.copyWith(color: Colors.grey, fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(children: [
                  InfoItem(num: "100", txt: "Posts"),
                  InfoItem(num: "256", txt: "Photos"),
                  InfoItem(num: "10K", txt: "Followers"),
                  InfoItem(num: "96", txt: "Following"),
                ]),
              ),
              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                          onPressed: () {}, child: const Text("Add Photos"))),
                  const SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        go_to(context, EditprofileScreen());
                      },
                      child: const Icon(Icons.edit))
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: () {
                          FirebaseMessaging.instance
                              .subscribeToTopic('subscribe');
                        },
                        child: const Text('SubScribe')),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: OutlinedButton(
                        onPressed: () {
                          FirebaseMessaging.instance
                              .unsubscribeFromTopic('subscribe');
                        },
                        child: const Text('UnSubScribe')),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Expanded InfoItem({required String num, required String txt}) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Text(
              num,
              style: Bodylestyle,
            ),
            Text(
              txt,
              style: Bodylestyle.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
