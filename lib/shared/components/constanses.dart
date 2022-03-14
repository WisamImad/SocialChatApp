import 'package:flutter/material.dart';

import '../../modules/social_login/login_screen.dart';
import '../network/local/cache_helper.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()), (
          route) => false);
    }
  });
}

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}

String token = CacheHelper.getData(key: 'token');

String? uId = CacheHelper.getData(key: 'uId');