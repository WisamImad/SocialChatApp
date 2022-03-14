import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:section9_social_chat/layout/cubit/states.dart';
import 'package:section9_social_chat/models/message_model.dart';
import 'package:section9_social_chat/models/post_model.dart';
import 'package:section9_social_chat/models/social_user_model.dart';
import 'package:section9_social_chat/modules/social_chats/chats_screen.dart';
import 'package:section9_social_chat/modules/social_feeds/feeds_screen.dart';
import 'package:section9_social_chat/modules/social_new_post/new_post_screen.dart';
import 'package:section9_social_chat/modules/social_settings/settings_screen.dart';
import 'package:section9_social_chat/modules/social_users/Users_screen.dart';
import 'package:section9_social_chat/shared/components/constanses.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model;

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      //print(value.data());
      model = SocialUserModel.fromjson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = ['Home', 'Chats', 'Post', 'Users', 'Settings'];

  void changeBottomNav(int index) {
    if (index == 1) {
      getUserChat();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  var picker = ImagePicker();
  File? profileImage;

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickerSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickerErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdatLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialProfileImagePickerSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        emit(SocialProfileImagePickerErrorState());
      });
    }).catchError((error) {
      emit(SocialProfileImagePickerErrorState());
    });
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickerSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickerErrorState());
    }
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdatLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialCoverImagePickerSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(SocialCoverImagePickerErrorState());
      });
    }).catchError((error) {
      emit(SocialCoverImagePickerErrorState());
    });
  }

  // void updateImageUser({
  //   required String name,
  //   required String phone,
  //   required String bio
  // }){
  //   emit(SocialUserUpdatLoadingState());
  //   if(coverImage != null){
  //     uploadCoverImage();
  //   }else if(profileImage != null){
  //     uploadProfileImage();
  //   }else{
  //     updateUser(name: name, phone: phone, bio: bio);
  //   }
  // }

  void updateUser(
      {required String name,
      required String phone,
      required String bio,
      String? image,
      String? cover}) {
    SocialUserModel userModel = SocialUserModel(
        name: name,
        phone: phone,
        bio: bio,
        email: model!.email,
        cover: cover ?? model!.cover,
        image: image ?? model!.image,
        uId: model!.uId,
        isEmailVerified: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdatErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickerSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickerErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemoveImagePickerState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel userModel = PostModel(
      name: model!.name,
      image: model!.image,
      uId: model!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(userModel.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> postModel = [];
  List<String> postId = [];
  List<int> likes = [];

  void getPost() {
    emit(SocialGetPostLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      //print(value.data());
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          postModel.add(PostModel.fromjson(element.data()));
        }).catchError((error) {});
      });
      emit(SocialGetPostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetPostErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error));
    });
  }

  List<String> comment = [];

  void commentPost({required String postId, required String comm}) {
    emit(SocialCommentPostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(model!.uId)
        .set({'comment': comm}).then((value) {
      emit(SocialCommentPostSuccessState());
    }).catchError((error) {
      emit(SocialCommentPostErrorState(error));
    });
  }

  List<SocialUserModel> users = [];

  void getUserChat() {
    if (users.length == 0) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        //print(value.data());
        value.docs.forEach((element) {
          if (element.data()['uId'] != model!.uId)
            users.add(SocialUserModel.fromjson(element.data()));
        });
        emit(SocialGetAllUserSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetAllUserErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel messageModel = MessageModel(
      text: text,
      senderId: model!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap()).then((value) {
          emit(SocialSendMessageSuccessState());
    }).catchError((error){
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uId)
        .collection('messages')
        .add(messageModel.toMap()).then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error){
      emit(SocialSendMessageErrorState());
    });

  }

  // Future = وظيفة هو بجيب الداتا مرة وحدة في المستقبل وبقفل
 // Stream = هي عبارة عن طابور من الداتا الي راح تيجي في المستقبل فهو بستنى كذا داتا وبضل مفتوح (reltime)

  List<MessageModel> message = [];
  
 void getMessages({
   required String receiverId,
}){
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
    .orderBy('dateTime')
        .snapshots()
        .listen((event) { 
          message = [];
          event.docs.forEach((element) {
            message.add(MessageModel.fromjson(element.data()));
          });
          emit(SocialGetMessageSuccessState());
    });
 }





}
