import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../layout/shopLayout.dart';
import '../../network/cache_helper.dart';
import '../../shared/component.dart';
import '../register/shop_register_screen.dart';

var controllerEmail = TextEditingController();
var controllerPassword = TextEditingController();
var keyForm = GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, AppState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (state.loginModel.status!) {
            CacheHelper.saveData(
                    key: 'token', value: state.loginModel.data!.token)
                .then((value) {
                  token= state.loginModel.data!.token;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShopLayout(),
                  ),
                  (route) => false);
              controllerEmail.clear();
              controllerPassword.clear();
            });
          } else {
            showToast(
                message: state.loginModel.message!, state: ToastState.ERROR);
          }
        }
        if (state is LoginErrorState) {
          showToast(message: 'Please Verify The Information Entered', state: ToastState.ERROR);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: keyForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Welcome to O-Bama Store',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(

                          controller: controllerEmail,
                          onFieldSubmitted: (value) {
                            if (keyForm.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  email: controllerEmail.text,
                                  password: controllerPassword.text);

                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },

                          decoration:  InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email_outlined),
                            labelText: 'Email',
                            hintText: 'enter your email',
                            hintStyle: TextStyle(color: Colors.grey),


                          ),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: controllerPassword,
                          obscureText: ShopLoginCubit.get(context).isPass,
                          onFieldSubmitted: (value) {
                            if (keyForm.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  email: controllerEmail.text,
                                  password: controllerPassword.text);
                            }
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'enter your password',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              onPressed: () {
                                ShopLoginCubit.get(context)
                                    .changeVisibilityPass();
                              },
                              icon: Icon(ShopLoginCubit.get(context).icon),
                            ),
                            labelText: 'Password',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                if (keyForm.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: controllerEmail.text,
                                      password: controllerPassword.text);
                                }
                              },
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          fallback: (context) => const Center(
                              child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account? ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                         RegisterScreen_(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
