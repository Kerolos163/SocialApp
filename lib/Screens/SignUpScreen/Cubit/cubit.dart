import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_app/Screens/SignUpScreen/Cubit/state.dart';

import '../../../model/Social.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(InitLogin());

  static SignUpCubit get(context) => BlocProvider.of(context);

  bool vis_pass = false;
  void change_vis() {
    print(vis_pass);
    vis_pass = !vis_pass;
    emit(password_visiability());
  }

  void UserRegister({
    required String Fname,
    required String Lname,
    required String email,
    required String pass,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      CreateUser(
          Fname: Fname, Lname: Lname, Uid: value.user!.uid, email: email);
      // emit(SocialRegisterSuccState());
    }).catchError((Error) {
      print(Error.toString());
      emit(SocialRegisterErrorState(Error.toString()));
    });
  }

  void CreateUser({
    required String Fname,
    required String Lname,
    required String email,
    required String Uid,
  }) {
    Social_model model = Social_model(
        Fname: Fname,
        Lname: Lname,
        email: email,
        Uid: Uid,
        isemail_verified: false,
        Image:
            'https://img.freepik.com/free-photo/photo-charismatic-lovely-woman-with-curly-hair-has-fun-toothy-smile-face_273609-30436.jpg',
        cover:
            'https://img.freepik.com/free-photo/photo-charismatic-lovely-woman-with-curly-hair-has-fun-toothy-smile-face_273609-30436.jpg',
        Bio: 'Write your Bio ...');
    FirebaseFirestore.instance
        .collection('Users')
        .doc(Uid)
        .set(model.tomap())
        .then((value) {
      emit(SocialCreateUserSuccState());
    }).catchError((Error) {
      emit(SocialCreateUserErrorState(Error.toString()));
    });
  }
}
