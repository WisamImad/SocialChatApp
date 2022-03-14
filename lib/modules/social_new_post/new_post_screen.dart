import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:section9_social_chat/layout/cubit/cubit.dart';
import 'package:section9_social_chat/layout/cubit/states.dart';
import 'package:section9_social_chat/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var postController = TextEditingController();
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(IconBroken.Arrow___Left_2),
            ),
            title: const Text('Create Post'),
            actions: [
              TextButton(
                  onPressed: () {
                    var now = DateTime.now();
                    if(SocialCubit.get(context).postImage == null){
                      SocialCubit.get(context).createPost(
                          dateTime: now.toString(),
                          text: postController.text);
                    }else{
                      SocialCubit.get(context).uploadPostImage(
                          dateTime: now.toString(),
                          text: postController.text);
                    }
                  },
                  child: const Text(
                    'POST',
                    style: TextStyle(fontSize: 14),
                  )),
              const SizedBox(
                width: 10.0,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  const SizedBox(height: 10.0,),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1513956589380-bad6acb9b9d4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'IT-Wisam Imad',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'public',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: TextFormField(
                    controller: postController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        hintText: 'What is on your mind, IT-Wisam Imad',
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                if(SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 140.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image: DecorationImage(
                                image: FileImage(SocialCubit.get(context).postImage!),
                                fit: BoxFit.cover)),
                      ),
                      IconButton(
                        icon: const CircleAvatar(
                          radius: 20.0,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.close),
                        ),
                        onPressed: (){
                          SocialCubit.get(context).removePostImage();
                        },
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                      onPressed: () {
                        SocialCubit.get(context).getPostImage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(IconBroken.Image),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('add photos'),
                        ],
                      ),
                    )),
                    Expanded(
                        child: TextButton(
                      onPressed: () {},
                      child: const Text('# tags'),
                    )),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
