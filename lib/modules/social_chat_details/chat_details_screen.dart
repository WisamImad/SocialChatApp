import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:section9_social_chat/layout/cubit/cubit.dart';
import 'package:section9_social_chat/layout/cubit/states.dart';
import 'package:section9_social_chat/models/message_model.dart';
import 'package:section9_social_chat/models/social_user_model.dart';
import 'package:section9_social_chat/shared/components/components.dart';
import 'package:section9_social_chat/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {

  SocialUserModel userModel;
  ChatDetailsScreen({required this.userModel});

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(receiverId: userModel.uId.toString());
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(IconBroken.Arrow___Left_2),
                ),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage('${userModel.image}'),
                    ),
                    SizedBox(width: 10.0,),
                    Text('${userModel.name}',style: Theme.of(context).textTheme.subtitle1,),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).message.length>0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context,index) {
                              var message = SocialCubit.get(context).message[index];
                              if(SocialCubit.get(context).model!.uId == message.senderId)
                                return buildMyMessage(message);
                              return buildMessage(message);
                            } ,
                            separatorBuilder: (context,index) => SizedBox(height: 15.0,),
                            itemCount: SocialCubit.get(context).message.length
                        ),
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(15.0)
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'type your message here ...',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50.0,
                              color: Colors.green,
                              child: MaterialButton(
                                onPressed: (){
                                  SocialCubit.get(context).sendMessage(
                                      receiverId: userModel.uId.toString(),
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text
                                  );
                                },
                                minWidth: 1.0,
                                child: const Icon(
                                  IconBroken.Send,
                                  size: 24.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                fallback: (context) => Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      }
    );
  }

  buildMessage(MessageModel messageModel) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          )
      ),
      child: Text('${messageModel.text}'),
      padding: const EdgeInsets.all(10.0),
    ),
  );

  buildMyMessage(MessageModel messageModel) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.4),
          borderRadius: const BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          )
      ),
      child: Text('${messageModel.text}'),
      padding: const EdgeInsets.all(10.0),
    ),
  );

}
