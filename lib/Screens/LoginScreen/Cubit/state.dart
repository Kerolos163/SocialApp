abstract class LoginState{}

class InitLogin extends LoginState{}
class password_visiability extends LoginState{}

class SocialLoginLoadingState extends LoginState{}
class SocialRegisterSuccState extends LoginState{
  String User_ID;
  SocialRegisterSuccState(this.User_ID);
}
class SocialRegisterErrorState extends LoginState{
  String error;
  SocialRegisterErrorState(this.error);
}