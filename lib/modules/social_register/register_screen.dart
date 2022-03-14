import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:section9_social_chat/layout/social_layout.dart';
import 'package:section9_social_chat/modules/social_login/login_screen.dart';
import 'package:section9_social_chat/modules/social_register/cubit/cubit.dart';
import 'package:section9_social_chat/modules/social_register/cubit/states.dart';
import 'package:section9_social_chat/shared/components/components.dart';

class RegisterScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context,state){
          if(state is SocialUserCreateSucessStates){
            navigateAndFinish(context, SocialLayout());
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign Up".toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          "SignUp now to browse our hot offers",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'name is Error or is not Exiset';
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.person),
                            focusColor: Colors.green,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Email is Error or is not Exiset';
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon: Icon(Icons.email),
                            focusColor: Colors.green,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'phone is too Short';
                            }
                          },
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {

                              print('True phone');
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Phone',
                            prefixIcon: Icon(Icons.phone),
                            focusColor: Colors.green,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Password is too Short';
                            }
                          },
                          onFieldSubmitted: (value) {
                              print('True login');
                          },
                          obscureText: SocialRegisterCubit.get(context).isPassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            focusColor: Colors.green,
                            suffixIcon: Icons.remove_red_eye != null
                                ? IconButton(
                                onPressed: () {
                                  SocialRegisterCubit.get(context).changePasswordVisibility();
                                },
                                icon: Icon(Icons.remove_red_eye))
                                : null,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingStates,
                          builder: (context) => defaultButton(
                              text: 'sign up'.toUpperCase(),
                              function: () {
                                if(formKey.currentState!.validate()){
                                  SocialRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text
                                  );
                                }
                                print('True signUp');
                              }
                          ),
                          fallback: (context) => const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already I have an account?',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (context) => LoginScreen()), (
                                      route) => false);
                                },
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(color: Colors.green),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
