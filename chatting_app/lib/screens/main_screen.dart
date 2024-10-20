import 'dart:io';

import 'package:chatting_app/data/user_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:chatting_app/config/palette.dart';
import 'package:chatting_app/add_image/add_image.dart';
// import 'package:chatting_app/screens/chat_screen.dart';

class LoginSignupScreen extends StatefulWidget {
  final UserData _userData;

  const LoginSignupScreen(
    this._userData, {
    super.key
  });

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isSignupScreen = true;
  final _formKey = GlobalKey<FormState>();
  String userName = '';
  String userEmail = '';
  String userPassword = '';
  File? userPickedImage;

  bool showSpinner = false;

  final _auth = FirebaseAuth.instance;

  void _setPickedImage(File image) {
    userPickedImage = image;
  }

  void _tryValidation() {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: AddImage(_setPickedImage),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(236, 243, 249, 1),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('image/red.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 90,
                      left: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Welcome',
                            style: TextStyle(
                              letterSpacing: 1.0,
                              fontSize: 25,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: isSignupScreen ? ' to Yummy chat!' : ' back',
                                style: TextStyle(
                                  letterSpacing: 1.0,
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ]
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          isSignupScreen ? 'Signup to continue' : 'Signin to continue',
                          style: TextStyle(
                            letterSpacing: 1.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                top: 180,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  padding: EdgeInsets.all(20.0),
                  height: isSignupScreen ? 280.0 : 250.0,
                  width: MediaQuery.of(context).size.width - 40.0,
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = false;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    'LOGIN',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: !isSignupScreen ? Palette.activeColor : Palette.textColor1,
                                    ),
                                  ),
                                  if (!isSignupScreen)
                                  Container(
                                    margin: EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: 55,
                                    color: Colors.orange
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = true;
                                });
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'SIGNUP',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isSignupScreen ? Palette.activeColor : Palette.textColor1,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      if (isSignupScreen)
                                      GestureDetector(
                                        onTap: () {
                                          _showAlert(context);
                                        },
                                        child: Icon(
                                          Icons.image,
                                          color: isSignupScreen ? Colors.cyan : Colors.grey[300],
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (isSignupScreen)
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 3, 35, 0),
                                    height: 2,
                                    width: 55,
                                    color: Colors.orange
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (isSignupScreen)
                        Container(
                          margin: EdgeInsets.only(top: 20.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  key: ValueKey(1),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 4) {
                                      return 'Please enter at least 4 characters.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userName = value!;
                                  },
                                  onChanged: (value) {
                                    userName = value;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.account_circle,
                                      color: Palette.iconColor,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palette.textColor1,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palette.textColor1,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                    ),
                                    hintText: 'User name',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Palette.textColor1,
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  key: ValueKey(2),
                                  validator: (value) {
                                    if (value!.isEmpty || !value.contains('@')) {
                                      return 'Please enter valid email address.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userEmail = value!;
                                  },
                                  onChanged: (value) {
                                    userEmail = value;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Palette.iconColor,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palette.textColor1,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palette.textColor1,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                    ),
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Palette.textColor1,
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  key: ValueKey(3),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 6) {
                                      return 'Password must be at least 6 characters long.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userPassword = value!;
                                  },
                                  onChanged: (value) {
                                    userPassword = value;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Palette.iconColor,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palette.textColor1,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palette.textColor1,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                    ),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Palette.textColor1,
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (!isSignupScreen)
                        Container(
                          margin: EdgeInsets.only(top: 20.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  key: ValueKey(4),
                                  validator: (value) {
                                    if (value!.isEmpty || !value.contains('@')) {
                                      return 'Please enter valid email address.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userEmail = value!;
                                  },
                                  onChanged: (value) {
                                    userEmail = value;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Palette.iconColor,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palette.textColor1,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palette.textColor1,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                    ),
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Palette.textColor1,
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  key: ValueKey(5),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 6) {
                                      return 'Password must be at least 6 characters long.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    userPassword = value!;
                                  },
                                  onChanged: (value) {
                                    userPassword = value;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Palette.iconColor,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palette.textColor1,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Palette.textColor1,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                                    ),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Palette.textColor1,
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                top: isSignupScreen ? 430.0 : 390.0,
                right: 0.0,
                left: 0.0,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    height: 90.0,
                    width: 90.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          showSpinner = true;
                        });

                        if (isSignupScreen) {
                          if (userPickedImage == null) {
                            setState(() {
                              showSpinner = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please pick your image'),
                                backgroundColor: Colors.blue,
                              ),
                            );
                            return;
                          }
                          _tryValidation();
        
                          try {
                            final UserCredential newUser = await _auth.createUserWithEmailAndPassword(
                              email: userEmail,
                              password: userPassword,
                            );

                            if (newUser.user != null) {
                              final refImage = FirebaseStorage.instance
                                .ref()
                                .child('picked_image')
                                .child('/' + newUser.user!.uid + '.png');
                              final metadata = SettableMetadata(
                                contentType: 'image/jpeg',
                                customMetadata: {'picked-file-path': userPickedImage!.path},
                              );
                              await refImage.putFile(userPickedImage!, metadata);

                              final imageUrl = await refImage.getDownloadURL();

                              await FirebaseFirestore.instance
                                .collection('user')
                                .doc(newUser.user!.uid)
                                .set({
                                  'userName': userName,
                                  'email': userEmail,
                                  'picked_image': imageUrl,
                                });

                              widget._userData.setUser(newUser);

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return ChatScreen();
                              //     },
                              //   ),
                              // );
                            }
                          }
                          catch (e) {
                            print('@@@ ' + e.toString());
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please check your email and password'),
                                backgroundColor: Colors.blue,
                              ),
                            );

                            setState(() {
                              showSpinner = false;
                            });
                          }
                        }
                        else {
                          _tryValidation();
        
                          try {
                            final UserCredential user = await _auth.signInWithEmailAndPassword(
                              email: userEmail,
                              password: userPassword,
                            );

                            widget._userData.setUser(user);

                            // if (signInUser.user != null) {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) {
                            //         return ChatScreen();
                            //       },
                            //     ),
                            //   );
                            // }
                          }
                          catch (e) {
                            print(e);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please check your email and password'),
                                backgroundColor: Colors.blue,
                              ),
                            );

                            setState(() {
                              showSpinner = false;
                            });
                          }
                        }

                        // setState(() {
                        //   showSpinner = false;
                        // });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.orange,
                              Colors.red,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                top: isSignupScreen ? MediaQuery.of(context).size.height - 125.0 : MediaQuery.of(context).size.height - 165.0,
                right: 0.0,
                left: 0.0,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: Column(
                  children: [
                    Text(isSignupScreen ? 'or Signup with' : 'or Signin with'),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton.icon(
                      onPressed: () {
          
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Palette.googleColor,
                        minimumSize: Size(155.0, 40.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      icon: Icon(Icons.add),
                      label: Text('Google'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
