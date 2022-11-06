import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/cubit_profile/states_profile.dart';
import 'package:shop_app/screens/shop/update_screen.dart';

import '../../cubit_profile/cubit_profile.dart';
import '../../shared/component.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {


      },
      builder: (context, state) {
        if (state is LoadingProfileData) {
          return const Center(child: CircularProgressIndicator());
        }
        // final player = AudioPlayer();
        final assetsAudioPlayer = AssetsAudioPlayer();
        model= ProfileCubit.get(context).UserDatas;

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          AssetImage('assets/images/profile_1.jpg'),
                    ),
                    CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.teal,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ))),
                  ],
                ),
                SizedBox(height: 10),
                // ProfileCubit.get(context).UserDatas!.data!.name
                Text(
                  ProfileCubit.get(context).UserDatas!.data!.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // ProfileCubit.get(context).UserDatas!.data!.email
                Text(ProfileCubit.get(context).UserDatas!.data!.email,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    )),
                SizedBox(height: 40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateScreen(),
                              ));
                        },
                        elevation: 0,
                        child: Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              color: Colors.teal,
                              size: 30,
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                'My Account',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, color: Colors.teal),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: MaterialButton(
                        onPressed: ()  {
                        showDialog(context: context, builder:  (context) {
                          return AlertDialog(

                            actionsPadding: EdgeInsetsDirectional.only(
                              bottom: 10,),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            title: Text('Invite Friends !!',
                                style: TextStyle(
                                  color: Colors.teal,
                                )),
                            content: Text(
                                'You don\'t have friends at all, Why press invite a friend ?!'),
                            actionsAlignment: MainAxisAlignment.spaceEvenly,
                            actions: [
                              Container(
                                width: 130,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: MaterialButton(
                                  onPressed: ()  {
                                    assetsAudioPlayer.open(
                                      Audio("assets/Lonely.wav"),
                                    );
                                    },
                                  child: const Text(
                                    'Lonely 🥰',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 130,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    assetsAudioPlayer.pause();
                                    Navigator.pop(context);



                                  },
                                  child: const Text(
                                    'Okey 🙂',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }

                        );

                        },
                        elevation: 0,
                        child: Row(
                          children: [
                            Icon(
                              Icons.person_add_alt,
                              color: Colors.teal,
                              size: 30,
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                'Invite a Friend',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, color: Colors.teal),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: "Notifications !!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.teal,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        },
                        elevation: 0,
                        child: Row(
                          children: [
                            Icon(
                              Icons.notifications_none_sharp,
                              color: Colors.teal,
                              size: 30,
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                'Notifications',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, color: Colors.teal),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  actionsPadding: EdgeInsetsDirectional.only(
                                    bottom: 10,),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  title: Text('Help & Support',
                                      style: TextStyle(
                                       color: Colors.teal,

                                      )),
                                  content: Text(
                                      'To contact us, please send us a message on www.Obama.com'),
                                  actions: [
                                    Center(
                                      child: Container(
                                        width: 100,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.teal,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'OK',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                );
                              });
                        },
                        elevation: 0,
                        child: Row(
                          children: [
                            Icon(
                              Icons.question_answer_outlined,
                              color: Colors.teal,
                              size: 30,
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                'Help & Support',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, color: Colors.teal),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  actionsPadding: EdgeInsetsDirectional.only(
                                      bottom: 10,),
                                  title: Text('Logout',
                                      style: TextStyle(
                                        color: Colors.teal,
                                      )),
                                  content: Text(
                                      'Are you sure you want to logout?'),
                                  actionsAlignment: MainAxisAlignment.spaceEvenly,
                                  actions: [
                                    Container(
                                      width: 100,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.teal,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: MaterialButton(
                                        onPressed: () {
                                          ProfileCubit.get(context).signOut_(context);

                                        },
                                        child: const Text(
                                          'Yes',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.teal,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: MaterialButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'No',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                        elevation: 0,
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.teal,
                              size: 30,
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                'Log Out',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, color: Colors.teal),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
