abstract class SocialState {}

class SocialIniteState extends SocialState {}

class SocialGetUserLoadingState extends SocialState {}

class SocialGetUserSuccState extends SocialState {}

class SocialGetUserErrorState extends SocialState {
  String error;
  SocialGetUserErrorState(this.error);
}

class SocialGetAllUserLoadingState extends SocialState {}

class SocialGetAllUserSuccState extends SocialState {}

class SocialGetAllUserErrorState extends SocialState {
  String error;
  SocialGetAllUserErrorState(this.error);
}

class SocialGetPostLoadingState extends SocialState {}

class SocialGetPostSuccState extends SocialState {}

class SocialGetPostErrorState extends SocialState {
  String error;
  SocialGetPostErrorState(this.error);
}

class SocialLikePostSuccState extends SocialState {}

class SocialLikePostErrorState extends SocialState {
  String error;
  SocialLikePostErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialState {}

class SocialNewPostState extends SocialState {}

class SocialProfileImagePickedSuccessState extends SocialState {}

class SocialProfileImagePickedErrorState extends SocialState {}

class SocialCoverImagePickedSuccessState extends SocialState {}

class SocialCoverImagePickedErrorState extends SocialState {}

class SocialPostImagePickedSuccessState extends SocialState {}

class SocialPostImagePickedErrorState extends SocialState {}

class SocialUploudProfileImageSuccessState extends SocialState {}

class SocialUploudProfileImageErrorState extends SocialState {}

class SocialUploudCoverImageSuccessState extends SocialState {}

class SocialUploudCoverImageErrorState extends SocialState {}

class SocialUserupdateLoading1State extends SocialState {}

class SocialUserupdateLoading2State extends SocialState {}

class SocialUserupdateErrorState extends SocialState {}

class SocialCreatePostSuccessState extends SocialState {}

class SocialCreatePostLoadingState extends SocialState {}

class SocialCreatePostErrorState extends SocialState {}

class SocialRemovePostErrorState extends SocialState {}

class SocialSendMessageSuccessState extends SocialState {}

class SocialGetMessageSuccessState extends SocialState {}

class SocialSendMessageErrorState extends SocialState {}

class SocialGetMessageErrorState extends SocialState {}

class SocialGetSendImageSuccessState extends SocialState {}

class SocialGetSendImageErrorState extends SocialState {}