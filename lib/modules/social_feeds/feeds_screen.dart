import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:section9_social_chat/layout/cubit/cubit.dart';
import 'package:section9_social_chat/layout/cubit/states.dart';
import 'package:section9_social_chat/models/post_model.dart';
import 'package:section9_social_chat/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  FeedsScreen({Key? key}) : super(key: key);

  var commentController = TextEditingController();
  var openComment = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: SocialCubit.get(context).postModel.length > 0 &&
                SocialCubit.get(context).model != null,
            builder: (context) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 5.0,
                        margin: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            const Image(
                              image: NetworkImage(
                                'https://img.freepik.com/free-photo/overjoyed-excited-woman-with-afro-hair-raises-palm-has-eyes-full-happiness-after-receiving-excellent-news-holds-mobile-phone-wears-spectacles-optical-glasses-isolated-brown-wall_273609-44115.jpg?w=740',
                              ),
                              fit: BoxFit.cover,
                              height: 200.0,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'communicate with friends',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => buildPostItem(
                              context,
                              SocialCubit.get(context).postModel[index],
                              index),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 8.0),
                          itemCount: SocialCubit.get(context).postModel.length),
                    ],
                  ),
                ),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget buildPostItem(context, PostModel model, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage('${model.image}'),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: const TextStyle(fontSize: 12,height: 1.3),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 16.0,
                            )
                          ],
                        ),
                        Text(
                          model.dateTime.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_horiz,
                        size: 16.0,
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
              //   child: SizedBox(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 1.0),
              //           child: SizedBox(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               height: 25.0,
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text('#softwaer',
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .caption!
              //                       .copyWith(color: Colors.blue)),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 1.0),
              //           child: SizedBox(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               height: 25.0,
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text('#flutter',
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .caption!
              //                       .copyWith(color: Colors.blue)),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 1.0),
              //           child: SizedBox(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               height: 25.0,
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text('#mobile_developer',
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .caption!
              //                       .copyWith(color: Colors.blue)),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 1.0),
              //           child: SizedBox(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               height: 25.0,
              //               minWidth: 1.0,
              //               padding: EdgeInsets.zero,
              //               child: Text('#softwaer',
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .caption!
              //                       .copyWith(color: Colors.blue)),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    width: double.infinity,
                    height: 140.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                            image: NetworkImage('${model.postImage}'),
                            fit: BoxFit.cover)),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Heart,
                              size: 16.0,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '${SocialCubit.get(context).likes[index]}',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              IconBroken.Chat,
                              size: 16.0,
                              color: Colors.amber,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '0 comment',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          //openComment = true;
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 15.0,
                              backgroundImage: NetworkImage(
                                  '${SocialCubit.get(context).model!.image}'),
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: commentController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    helperMaxLines: 2,
                                    hintText: 'write a comment ...',
                                    border: InputBorder.none,
                                    suffixIcon: IconButton(
                                      icon: Icon(IconBroken.Send),
                                      onPressed: () {
                                        // SocialCubit.get(context).commentPost(
                                        //     postId: SocialCubit.get(context)
                                        //         .postId[index],
                                        //     comm: commentController.text);
                                        // commentController =
                                        //     '' as TextEditingController;
                                      },
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        SocialCubit.get(context)
                            .likePost(SocialCubit.get(context).postId[index]);
                      },
                      child: Row(
                        children: [
                          const Icon(
                            IconBroken.Heart,
                            size: 16.0,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Like',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
