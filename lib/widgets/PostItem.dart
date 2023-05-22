import 'package:flutter/material.dart';
import 'package:social_app/Cubit/cubit.dart';

import '../Theme/theme.dart';
import '../model/Postmodel.dart';

class BuildpostItem extends StatelessWidget {
  postmodel model;
  int index;
  BuildpostItem(this.model,this.index);
  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(model.Image),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${model.Fname} ${model.Lname}",
                            style: const TextStyle(height: 1.4),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 16,
                          )
                        ],
                      ),
                      Text(
                        model.datetime,
                        style: Body2lestyle.copyWith(
                            fontSize: 11, color: Colors.black87, height: 1.4),
                      )
                    ],
                  )),
                  const SizedBox(
                    width: 15,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_horiz,
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                model.text,
                style: Body2lestyle.copyWith(height: 1.3),
              ),
              // //Tags
              // Container(
              //   width: double.infinity,
              //   padding: const EdgeInsets.symmetric(vertical: 5),
              //   child: Wrap(
              //     children: [
              //       Container(
              //         height: 20,
              //         padding: const EdgeInsetsDirectional.only(end: 5),
              //         child: MaterialButton(
              //           onPressed: () {},
              //           minWidth: 1,
              //           padding: EdgeInsets.zero,
              //           child: const Text(
              //             "#software",
              //             style: TextStyle(color: Colors.blue),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 20,
              //         padding: const EdgeInsetsDirectional.only(end: 5),
              //         child: MaterialButton(
              //           onPressed: () {},
              //           minWidth: 1,
              //           padding: EdgeInsets.zero,
              //           child: const Text(
              //             "#IOS",
              //             style: TextStyle(color: Colors.blue),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 20,
              //         padding: const EdgeInsetsDirectional.only(end: 5),
              //         child: MaterialButton(
              //           onPressed: () {},
              //           minWidth: 1,
              //           padding: EdgeInsets.zero,
              //           child: const Text(
              //             "#Flutter",
              //             style: TextStyle(color: Colors.blue),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 20,
              //         padding: const EdgeInsetsDirectional.only(end: 5),
              //         child: MaterialButton(
              //           onPressed: () {},
              //           minWidth: 1,
              //           padding: EdgeInsets.zero,
              //           child: const Text(
              //             "#software_development",
              //             style: TextStyle(color: Colors.blue),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              //  Image
              if (model.postimage != "")
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(model.postimage))),
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children:  [
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text("${SocialAppCubit.get(context).likes[index]}")
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:  [
                            const Icon(
                              Icons.comment,
                              color: Colors.blue,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text("${SocialAppCubit.get(context).comment[index]}")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(SocialAppCubit.get(context).usermodel!.Image),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Write a comment ...",
                            style: Body2lestyle.copyWith(
                                fontSize: 12,
                                color: Colors.black87,
                                height: 1.4),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      SocialAppCubit.get(context).likePost(SocialAppCubit.get(context).postsID[index]);
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Love")
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
