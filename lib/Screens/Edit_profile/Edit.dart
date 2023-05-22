import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Cubit/cubit.dart';
import '../../Cubit/state.dart';
import '../../imp_func.dart';
import '../../widgets/botton.dart';
import '../../widgets/text_field.dart';

class EditprofileScreen extends StatelessWidget {
  EditprofileScreen({super.key});
  var fnameController = TextEditingController();
  var lnameController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var usermodel = SocialAppCubit.get(context).usermodel;
        var ProfileImage = SocialAppCubit.get(context).ProfileImage;
        var CoverImage = SocialAppCubit.get(context).CoverImage;

        fnameController.text = usermodel!.Fname;
        lnameController.text = usermodel.Lname;

        bioController.text = usermodel.Bio;
        return Scaffold(
          appBar: appbar(context, t: "Edit Profile", act: [
            Mybutton(
              label: "Update",
              onTap: () {
                SocialAppCubit.get(context).updateuser(
                    Fname: fnameController.text,
                    Lname: lnameController.text,
                    bio: bioController.text);
              },
              fcolor: Colors.white,
            )
          ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialGetUserLoadingState)
                    const LinearProgressIndicator(),

                  SizedBox(
                    height: 200,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                    ),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CoverImage == null
                                            ? NetworkImage(
                                                usermodel.cover as String)
                                            : FileImage(CoverImage)
                                                as ImageProvider)),
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocialAppCubit.get(context).getCoverimage();
                                  },
                                  icon: const CircleAvatar(
                                    radius: 14,
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 20,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: ProfileImage == null
                                    ? NetworkImage(usermodel.Image as String)
                                    : FileImage(ProfileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  SocialAppCubit.get(context).getprofileimage();
                                },
                                icon: CircleAvatar(
                                  radius: 50,
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: const CircleAvatar(
                                    radius: 14,
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 20,
                                    ),
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  if (SocialAppCubit.get(context).ProfileImage != null ||
                      SocialAppCubit.get(context).CoverImage != null)
                    Row(
                      children: [
                        if (SocialAppCubit.get(context).ProfileImage != null)
                          Expanded(
                              child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                        onPressed: () {
                                          SocialAppCubit.get(context)
                                              .UploadProfileImage(
                                                  Fname: fnameController.text,
                                                  Lname: lnameController.text,
                                                  bio: bioController.text);
                                        },
                                        child: const Text("Upload Profile")),
                                  ),
                                ],
                              ),
                              if (state is SocialUserupdateLoading1State)
                                const SizedBox(
                                  height: 2,
                                ),
                              if (state is SocialUserupdateLoading1State)
                                const LinearProgressIndicator()
                            ],
                          )),
                        const SizedBox(
                          width: 10,
                        ),
                        if (SocialAppCubit.get(context).CoverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                          onPressed: () {
                                            SocialAppCubit.get(context)
                                                .UploadcoverImage(
                                                    Fname: fnameController.text,
                                                    Lname: lnameController.text,
                                                    bio: bioController.text);
                                          },
                                          child: const Text("Upload Cover")),
                                    ),
                                  ],
                                ),
                                if (state is SocialUserupdateLoading2State)
                                  const SizedBox(
                                    height: 2,
                                  ),
                                if (state is SocialUserupdateLoading2State)
                                  const LinearProgressIndicator()
                              ],
                            ),
                          ),
                      ],
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TEXTFIELD(
                            fnameController,
                            TextInputType.name,
                            "First Name",
                            "Please enter your First name",
                            const Icon(Icons.person_outline),
                            false),
                      ),
                      Expanded(
                        child: TEXTFIELD(
                            lnameController,
                            TextInputType.name,
                            "Last Name",
                            "Please enter your Last name",
                            const Icon(Icons.person_outline),
                            false),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TEXTFIELD(
                      bioController,
                      TextInputType.text,
                      "Bio",
                      "Please enter your BIO ",
                      const Icon(Icons.info_outline),
                      false),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
