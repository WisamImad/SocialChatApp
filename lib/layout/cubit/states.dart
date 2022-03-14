abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates{
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialGetAllUserLoadingState extends SocialStates{}

class SocialGetAllUserSuccessState extends SocialStates{}

class SocialGetAllUserErrorState extends SocialStates{
  final String error;

  SocialGetAllUserErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates{}

class SocialNewPostState extends SocialStates{}

// Get Image form Gallery
class SocialProfileImagePickerSuccessState extends SocialStates{}

class SocialProfileImagePickerErrorState extends SocialStates{}

class SocialCoverImagePickerSuccessState extends SocialStates{}

class SocialCoverImagePickerErrorState extends SocialStates{}

// upload image
class SocialUploadProfileImageSuccessState extends SocialStates{}

class SocialUploadProfileImageErrorState extends SocialStates{}

// uplaod cover
class SocialUploadCoverImageSuccessState extends SocialStates{}

class SocialUploadCoverImageErrorState extends SocialStates{}

// User update data
class SocialUserUpdatLoadingState extends SocialStates{}

class SocialUserUpdatErrorState extends SocialStates{}

// Create Post
class SocialCreatePostLoadingState extends SocialStates{}

class SocialCreatePostSuccessState extends SocialStates{}

class SocialCreatePostErrorState extends SocialStates{}

class SocialPostImagePickerSuccessState extends SocialStates{}

class SocialPostImagePickerErrorState extends SocialStates{}

class SocialRemoveImagePickerState extends SocialStates{}

// get post
class SocialGetPostLoadingState extends SocialStates{}

class SocialGetPostSuccessState extends SocialStates{}

class SocialGetPostErrorState extends SocialStates{
  final String error;

  SocialGetPostErrorState(this.error);
}

// like post

class SocialLikePostSuccessState extends SocialStates{}

class SocialLikePostErrorState extends SocialStates{
  final String error;

  SocialLikePostErrorState(this.error);
}

// comment post

class SocialCommentPostLoadingState extends SocialStates{}

class SocialCommentPostSuccessState extends SocialStates{}

class SocialCommentPostErrorState extends SocialStates{
  final String error;

  SocialCommentPostErrorState(this.error);
}

// message

class SocialSendMessageSuccessState extends SocialStates{}

class SocialSendMessageErrorState extends SocialStates{}

class SocialGetMessageSuccessState extends SocialStates{}

class SocialGetMessageErrorState extends SocialStates{}