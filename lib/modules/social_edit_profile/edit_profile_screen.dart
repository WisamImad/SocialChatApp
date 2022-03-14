import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:section9_social_chat/layout/cubit/cubit.dart';
import 'package:section9_social_chat/layout/cubit/states.dart';
import 'package:section9_social_chat/shared/components/components.dart';
import 'package:section9_social_chat/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {

        var model = SocialCubit.get(context).model!;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = model.name!;
        phoneController.text = model.phone!;
        bioController.text = model.bio!;

        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(IconBroken.Arrow___Left_2),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text('Edit Profile'),
              actions: [
                TextButton(
                    onPressed: () {
                      SocialCubit.get(context).updateUser(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text);
                    },
                    child: const Text('UPDATE')),
                const SizedBox(
                  width: 8.0,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is SocialUserUpdatLoadingState)
                      const LinearProgressIndicator(),
                    if (state is SocialUserUpdatLoadingState)
                      const SizedBox(
                        height: 5.0,
                      ),
                    SizedBox(
                      height: 190,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: coverImage == null
                                            ? NetworkImage('${model.cover}')
                                            : FileImage(coverImage)
                                        as ImageProvider,
                                        fit: BoxFit.cover),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0)),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: const CircleAvatar(
                                    radius: 15,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            alignment: AlignmentDirectional.topCenter,
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 62,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage('${model.image}')
                                      : FileImage(
                                      profileImage) as ImageProvider,
                                ),
                              ),
                              IconButton(
                                icon: const CircleAvatar(
                                  radius: 15,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 15,
                                  ),
                                ),
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    if(SocialCubit.get(context).profileImage != null ||
                        SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if(SocialCubit.get(context).profileImage != null)
                         Expanded(
                            child: defaultButton(
                              function: (){
                                SocialCubit.get(context).uploadProfileImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text);
                              },
                              text: 'Update Image'
                            ),
                        ),
                        SizedBox(width: 5.0,),
                        if(SocialCubit.get(context).coverImage != null)
                         Expanded(
                          child: defaultButton(
                              function: (){
                                SocialCubit.get(context).uploadCoverImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text);
                              },
                              text: 'Update Cover'
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: nameController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        label: Text('Name'),
                        prefixIcon: const Icon(IconBroken.User),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: phoneController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Phone must not be empty';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        label: const Text('Phone'),
                        prefixIcon: const Icon(IconBroken.Call),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: bioController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Bio must not be empty';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: model.bio,
                        label: const Text('Bio'),
                        prefixIcon: const Icon(IconBroken.Info_Circle),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            )
        );
      },
    );
  }
}
