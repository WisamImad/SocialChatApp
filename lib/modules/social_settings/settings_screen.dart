import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:section9_social_chat/layout/cubit/cubit.dart';
import 'package:section9_social_chat/layout/cubit/states.dart';
import 'package:section9_social_chat/modules/social_edit_profile/edit_profile_screen.dart';
import 'package:section9_social_chat/shared/components/components.dart';
import 'package:section9_social_chat/shared/components/constanses.dart';
import 'package:section9_social_chat/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).model;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 190.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        child: Container(
                          width: double.infinity,
                          height: 140.0,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(4.0),
                                  topLeft: Radius.circular(4.0)),
                              image: DecorationImage(
                                  image: NetworkImage('${userModel!.cover}'),
                                  fit: BoxFit.cover)),
                        ),
                        alignment: AlignmentDirectional.topCenter,
                      ),
                      CircleAvatar(
                        radius: 64.0,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundImage: NetworkImage('${userModel.image}'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  '${userModel.name}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${userModel.bio}',
                  style: Theme.of(context).textTheme.caption,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '89',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Posts',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '24',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Photoes',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '10k',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Followers',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '54',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                'Followings',
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () {},
                            child: const Text('Add Pohots'))
                    ),
                    const SizedBox(width: 10.0,),
                    OutlinedButton(
                        onPressed: () {
                          navigateTo(context, EditProfileScreen());
                        },
                        child: const Icon(IconBroken.Edit),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                      onPressed: () {
                        FirebaseMessaging.instance.subscribeToTopic('announcements');
                      },
                      child: Text("subscribe"),
                    )),
                    SizedBox(width: 10.0,),
                    Expanded(
                        child: OutlinedButton(
                      onPressed: () {
                        FirebaseMessaging.instance.unsubscribeFromTopic('announcements');
                      },
                      child: Text("unsubscribe"),
                    )),
                  ],
                ),
              ],
            ),
            
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: (){
                signOut(context);
              },
            child: Icon(IconBroken.Logout),
          ),
        );
      },
    );
  }
}
