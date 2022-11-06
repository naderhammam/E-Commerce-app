import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit_profile/cubit_profile.dart';
import '../../cubit_profile/states_profile.dart';
import '../../shared/component.dart';

var controllerEmail = TextEditingController();
var controllerPhone = TextEditingController();
var controllerName = TextEditingController();

var keyForm = GlobalKey<FormState>();

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        if (state is LoadingProfileData) {
          return Scaffold(body: const Center(child: CircularProgressIndicator()));
        }


        controllerEmail.text = '${model.data!.email}';
        controllerPhone.text = '${model.data!.phone}';
        controllerName.text = '${model.data!.name}';

        return Scaffold(
          appBar: AppBar(
            title: Text('My Account'),
          ),
          body: (ProfileCubit.get(context).UserDatas == null)
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20, 60, 20, 20),
                    child: Form(
                      key: keyForm,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: controllerName,
                            onFieldSubmitted: (value) {},
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.person),
                              labelText: 'Name',
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: controllerEmail,
                            onFieldSubmitted: (value) {},
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email_outlined),
                              labelText: 'Email',
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: controllerPhone,
                            onFieldSubmitted: (value) {},
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your phone';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.phone_android_rounded),
                              labelText: 'Phone',
                            ),
                          ),


                          const SizedBox(height: 8),
                          if (state is LoadingUpdateData)
                            LinearProgressIndicator(),
                          const SizedBox(height: 25),
                          Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                ProfileCubit.get(context).getUpdateData(
                                  name: controllerName.text,
                                  email: controllerEmail.text,
                                  phone: controllerPhone.text,
                                );
                              },
                              child: const Text(
                                'UPDATE',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
