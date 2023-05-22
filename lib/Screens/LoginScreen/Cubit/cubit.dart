import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Screens/LoginScreen/Cubit/state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitLogin());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool vis_pass = false;

  void change_vis() {
    print(vis_pass);
    vis_pass = !vis_pass;
    emit(password_visiability());
  }

  void userLogin({required email, required pass}) {
    emit(SocialLoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) {
          print(value.user!.email);
          print(value.user!.uid);
          
      emit(SocialRegisterSuccState(value.user!.uid));
    }).catchError((Error) {
      emit(SocialRegisterErrorState(Error.toString()));
    });
  }
}
