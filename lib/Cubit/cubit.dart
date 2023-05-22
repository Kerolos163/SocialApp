import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Cubit/state.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Screens/Chats/Chats_Screen.dart';
import '../Screens/Feeds/Feeds_Screen.dart';
import '../Screens/NewPost/NewPost.dart';
import '../Screens/Settings/SettingScreen.dart';
import '../Screens/Users/Users_Screen.dart';
import '../Shared_Pref/Share_Pref.dart';
import '../model/Postmodel.dart';
import '../model/Social.dart';
import '../model/messagemodel.dart';

class SocialAppCubit extends Cubit<SocialState> {
  SocialAppCubit() : super(SocialIniteState());

  static SocialAppCubit get(context) => BlocProvider.of(context);
  Social_model? usermodel;
  void GetUserData() {
    emit(SocialGetUserLoadingState());
    var UID = Sharepref.getdata(key: "U_ID");
    FirebaseFirestore.instance.collection('Users').doc(UID).get().then((value) {
      print(
          "**********************************************************************");
      print(value.data());
      print(
          "**********************************************************************");
      usermodel = Social_model.fromJson(value.data() as Map<String, dynamic>);
      print(usermodel!.Uid);
      emit(SocialGetUserSuccState());
    }).catchError((Error) {
      print(Error.toString());
      emit(SocialGetUserErrorState(Error.toString()));
    });
  }

  int CurrentIndex = 0;
  List<Widget> Screens = [
    const FeedSScreen(),
    const ChatSScreen(),
    Newpost(),
    const UserScreen(),
    const SettingScreen()
  ];

  List<String> Titles = ["Home", "Chats", "Post", "Users", "Settings"];

  void ChangeBottomNav(int index) {
    if (index == 1) {
      print(Users);
      GetUser();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      CurrentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? ProfileImage;
  final ImagePicker _picker = ImagePicker();

  getprofileimage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      ProfileImage = File(image.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print("No Image Selected !");
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? CoverImage;

  getCoverimage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      CoverImage = File(image.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print("No Image Selected !");
      emit(SocialProfileImagePickedErrorState());
    }
  }

  void UploadProfileImage(
      {required String Fname, required String Lname, required String bio}) {
    emit(SocialUserupdateLoading1State());
    final storage = FirebaseStorage.instance;
    storage
        .ref()
        .child('users/${Uri.file(ProfileImage!.path).pathSegments.last}')
        .putFile(ProfileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploudProfileImageSuccessState());
        print(value);
        updateuser(Fname: Fname, Lname: Lname, bio: bio, img: value);
      }).catchError((Error) {
        emit(SocialUploudProfileImageErrorState());
      });
    }).catchError((Error) {
      emit(SocialUploudProfileImageErrorState());
    });
  }

  void UploadcoverImage(
      {required String Fname, required String Lname, required String bio}) {
    emit(SocialUserupdateLoading2State());
    final storage = FirebaseStorage.instance;
    storage
        .ref()
        .child('users/${Uri.file(CoverImage!.path).pathSegments.last}')
        .putFile(CoverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploudCoverImageSuccessState());
        print(value);
        updateuser(Fname: Fname, Lname: Lname, bio: bio, Cover: value);
      }).catchError((Error) {
        emit(SocialUploudCoverImageErrorState());
      });
    }).catchError((Error) {
      emit(SocialUploudCoverImageErrorState());
    });
  }

  // void updateuserImage(
  //     {required String Fname, required String Lname, required String bio}) {
  //   emit(SocialUserupdateLoadingState());
  //   if (CoverImage != null) {
  //     UploadcoverImage();
  //   } else if (ProfileImage != null) {
  //     UploadProfileImage();
  //   } else if (CoverImage != null && ProfileImage != null) {
  //   } else {
  //     updateuser(Fname: Fname, Lname: Lname, bio: bio);
  //   }
  // }

  void updateuser(
      {required String Fname,
      required String Lname,
      required String bio,
      String? img,
      String? Cover}) {
    Social_model model = Social_model(
      Fname: Fname,
      Lname: Lname,
      Bio: bio,
      Image: img ?? usermodel!.Image,
      cover: Cover ?? usermodel!.cover,
      email: usermodel!.email,
      Uid: usermodel!.Uid,
      isemail_verified: false,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(usermodel!.Uid)
        .update(model.tomap())
        .then((value) => GetUserData())
        .catchError((Error) {
      emit(SocialUserupdateErrorState());
    });
  }

  File? postImage;

  getpostimage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      postImage = File(image.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print("No Image Selected !");
      emit(SocialPostImagePickedErrorState());
    }
  }

  void remove_postImage() {
    postImage = null;
    emit(SocialRemovePostErrorState());
  }

  void Uploadpost({
    required String datetime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    final storage = FirebaseStorage.instance;
    storage
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploudCoverImageSuccessState());
        print(value);
        // updateuser(Fname: Fname, Lname: Lname, bio: bio, Cover: value);
        createpost(datetime: datetime, text: text, PostImage: value);
      }).catchError((Error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((Error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createpost(
      {required String datetime, required String text, String? PostImage}) {
    emit(SocialCreatePostLoadingState());
    postmodel model = postmodel(
        Fname: usermodel!.Fname,
        Lname: usermodel!.Lname,
        Image: usermodel!.Image,
        Uid: usermodel!.Uid,
        datetime: datetime,
        text: text,
        postimage: PostImage ?? "");
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.tomap())
        .then((value) {
      GetPost();
      emit(SocialCreatePostSuccessState());
    }).catchError((Error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<postmodel> posts = [];
  List<String> postsID = [];
  List<int> likes = [];
  List<int> comment = [];
  void GetPost() {
    posts = [];
    postsID = [];
    likes = [];
    comment = [];
    emit(SocialGetPostLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          element.reference.collection('Comments').get().then(
            (com) {
              comment.add(com.docs.length);
              postsID.add(element.id);
              posts.add(postmodel.fromJson(element.data()));
              emit(SocialGetPostSuccState());
            },
          );
        }).catchError((Error) {});
      });

      // emit(SocialGetPostSuccState());
    }).catchError((Error) {
      emit(SocialGetPostErrorState(Error.toString()));
    });
  }

  void likePost(String postid) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('likes')
        .doc(usermodel!.Uid)
        .set({'Like': true}).then((value) {
      emit(SocialLikePostSuccState());
    }).catchError((Error) {
      emit(SocialLikePostErrorState(Error.toString()));
    });
  }

  List<Social_model> Users = [];
  void GetUser() {
    Users = [];
    emit(SocialGetAllUserLoadingState());
    FirebaseFirestore.instance.collection('Users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['Uid'] != usermodel!.Uid) {
          Users.add(Social_model.fromJson(element.data()));
        }
      });
      emit(SocialGetAllUserSuccState());
    }).catchError((Error) {
      emit(SocialGetAllUserErrorState(Error.toString()));
    });
  }

  void SendMessage({
    required String receiverId,
    required String DateTime,
    required String text,
    String? image,
  }) {
    messagemodel model = messagemodel(
        receiverid: receiverId,
        senderid: usermodel!.Uid,
        datetime: DateTime,
        text: text,
        Image:image??"");
    // Set My Chats
    FirebaseFirestore.instance
        .collection('Users')
        .doc(usermodel!.Uid)
        .collection('Chats')
        .doc(receiverId)
        .collection('Message')
        .add(model.tomap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((Error) {
      emit(SocialSendMessageErrorState());
    });
    // Set Receiver Chats
    FirebaseFirestore.instance
        .collection('Users')
        .doc(receiverId)
        .collection('Chats')
        .doc(usermodel!.Uid)
        .collection('Message')
        .add(model.tomap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((Error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<messagemodel> Message = [];
  void GetMessage({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(usermodel!.Uid)
        .collection('Chats')
        .doc(receiverId)
        .collection('Message')
        .orderBy('datetime')
        .snapshots()
        .listen((event) {
      Message = [];
      event.docs.forEach((element) {
        Message.add(messagemodel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }

  File? SendImg;

  GetSendimage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      SendImg = File(image.path);
      print('Get SendImage Done <----------------------------->');
      print(SendImg);

      emit(SocialGetSendImageSuccessState());
    } else {
      print("No Image Selected !");
      emit(SocialGetSendImageErrorState());
    }
  }
    void remove_SendImage() {
    SendImg = null;
    emit(SocialRemovePostErrorState());
  }

  uploadimag({
    required String receiverId,
    required String DateTime,
    required String text,
    String? image,
  }) {
    final storage = FirebaseStorage.instance;
    storage
        .ref()
        .child('Messages/${Uri.file(SendImg!.path).pathSegments.last}')
        .putFile(SendImg!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        SendMessage(receiverId: receiverId, DateTime: DateTime, text: text,image: value);
        // emit(SocialUploudCoverImageSuccessState());
      }).catchError((Error) {
        // emit(SocialUploudCoverImageErrorState());
      });
    }).catchError((Error) {});
  }
}
