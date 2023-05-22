import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubit/cubit.dart';
import 'package:social_app/Cubit/state.dart';
import 'package:social_app/Screens/Chat_Details/Chat_Details.dart';
import 'package:social_app/imp_func.dart';

import '../../model/Social.dart';

class ChatSScreen extends StatelessWidget {
  const ChatSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialAppCubit.get(context).Users.isNotEmpty,
          builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildchatitem(SocialAppCubit.get(context).Users[index],context),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemCount: SocialAppCubit.get(context).Users.length),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildchatitem(Social_model model,context) => InkWell(
        onTap: () {
          go_to(context, ChatDetailScreen(model));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children:  [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    model.Image),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                '${model.Fname} ${model.Lname}',
                style: const TextStyle(height: 1.4),
              )
            ],
          ),
        ),
      );
}
