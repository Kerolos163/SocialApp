import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubit/cubit.dart';
import 'package:social_app/Cubit/state.dart';

import '../../Theme/theme.dart';
import '../../widgets/PostItem.dart';

class FeedSScreen extends StatelessWidget {
  const FeedSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialState>(
      listener: (context, state) {
        if(state is! SocialGetPostLoadingState)
        {
          print("Done");
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! SocialGetPostLoadingState&& SocialAppCubit.get(context).usermodel != null &&SocialAppCubit.get(context).posts.isNotEmpty,
          builder: (context) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 10,
                    margin: const EdgeInsets.all(8),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        const Image(
                          image: NetworkImage(
                              'https://img.freepik.com/free-photo/photo-delighted-cheerful-afro-american-woman-with-crisp-hair-points-away-shows-blank-space-happy-advertise-item-sale-wears-orange-jumper-demonstrates-where-clothes-shop-situated_273609-26392.jpg?w=1060&t=st=1675993284~exp=1675993884~hmac=a7dc8d06af47713c806596a9d0143fcf39632f9c2eed8fb2dc86e9e15e2d6a03'),
                          fit: BoxFit.cover,
                          height: 250,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              child: Text(
                                "Communicate With Friends",
                                style: Body2lestyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return  BuildpostItem(SocialAppCubit.get(context).posts[index],index);
                    },
                    itemCount: SocialAppCubit.get(context).posts.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 8,
                      );
                    },
                  ),
                ],
              ),
            );
          },
          fallback: (context) {
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}
