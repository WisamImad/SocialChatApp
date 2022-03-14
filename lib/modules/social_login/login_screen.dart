import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:section9_social_chat/layout/social_layout.dart';
import 'package:section9_social_chat/modules/social_login/cubit/cubit.dart';
import 'package:section9_social_chat/modules/social_login/cubit/states.dart';
import 'package:section9_social_chat/modules/social_register/register_screen.dart';
import 'package:section9_social_chat/shared/network/local/cache_helper.dart';

import '../../shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
          listener: (context, state) {
        if (state is SocialLoginErrorState) {
          showToast(text: state.error, state: ToastState.ERROR);
        }
        if (state is SocialLoginSuccessState) {
          CacheHelper.saveData2(key: 'uId', value: state.uId)
              .then((value) {
            navigateAndFinish(context, SocialLayout());
          });
        }
      }, builder: (context, state) {
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
                        "Login".toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        "login now to communicate with friends",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Email is Error or is not Exiset';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          prefixIcon: Icon(Icons.email),
                          focusColor: Colors.green,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 30,
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
                          if (formKey.currentState!.validate()) {
                            SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                            print('True login');
                          }
                        },
                        obscureText: SocialLoginCubit.get(context).isPassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline),
                          focusColor: Colors.green,
                          suffixIcon: Icons.remove_red_eye != null
                              ? IconButton(
                                  onPressed: () {
                                    SocialLoginCubit.get(context)
                                        .changePasswordVisibility();
                                  },
                                  icon: Icon(Icons.remove_red_eye))
                              : null,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: state is! SocialLoginLoadingState,
                        builder: (context) => defaultButton(
                            text: 'Login'.toUpperCase(),
                            function: () {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                                print('True login');
                              }
                            }),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don’t have an account?',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => RegisterScreen()),
                                    (route) => false);
                              },
                              child: Text(
                                'REGISTER',
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
      }),
    );
  }
}
