import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:section9_social_chat/layout/cubit/cubit.dart';
import 'package:section9_social_chat/layout/social_layout.dart';
import 'package:section9_social_chat/shared/components/components.dart';

import 'modules/social_login/login_screen.dart';
import 'shared/cubit/cubit.dart';
import 'shared/cubit/states.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/styles/bloc_observer.dart';
import 'shared/styles/themes.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.data}");
  showToast(text: 'on Message background', state: ToastState.SUCCES);
}

void main() async{

  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  var token = await FirebaseMessaging.instance.getToken();
  print("Token = $token");
  FirebaseMessaging.onMessage.listen((event) {
    print("message = ${event.data}");
    showToast(text: 'on Message', state: ToastState.SUCCES);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print("message open = ${event.data}");
    showToast(text: 'on Message Open', state: ToastState.SUCCES);
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  Widget widget;

  var uId = CacheHelper.getData(key: 'uId');

  if(uId != null){
    widget = const SocialLayout();
  }else{
    widget = LoginScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;

  const MyApp({Key? key, required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData()..getPost(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
