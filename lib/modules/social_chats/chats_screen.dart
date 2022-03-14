import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:section9_social_chat/layout/cubit/cubit.dart';
import 'package:section9_social_chat/layout/cubit/states.dart';
import 'package:section9_social_chat/models/social_user_model.dart';
import 'package:section9_social_chat/modules/social_chat_details/chat_details_screen.dart';
import 'package:section9_social_chat/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: SocialCubit.get(context).users.length > 0,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => bildItemUser(context,SocialCubit.get(context).users[index]),
                separatorBuilder: (context,index) => myDivider(),
                itemCount: SocialCubit.get(context).users.length),
            fallback: (context) => const Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget bildItemUser(context, SocialUserModel model) => InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(userModel: model,));
    },
    child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                '${model.name}',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16.0),
              )
            ],
          ),
        ),
  );
}
