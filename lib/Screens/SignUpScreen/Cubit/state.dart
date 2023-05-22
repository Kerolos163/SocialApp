abstract class SignUpState{}

class InitLogin extends SignUpState{}
class password_visiability extends SignUpState{}
class SocialRegisterLoadingState extends SignUpState{}
class SocialRegisterSuccState extends SignUpState{}
class SocialRegisterErrorState extends SignUpState{
  String error;
  SocialRegisterErrorState(this.error);
}
class SocialCreateUserSuccState extends SignUpState{}
class SocialCreateUserErrorState extends SignUpState{
  String error;
  SocialCreateUserErrorState(this.error);
}