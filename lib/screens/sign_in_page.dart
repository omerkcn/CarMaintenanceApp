import 'package:car_services_app/on_board.dart';
import 'package:car_services_app/screens/sign_in_page_2.dart';
import 'package:car_services_app/screens/sign_in_page_model_view.dart';
import 'package:car_services_app/services/auth.dart';
import 'package:car_services_app/widgets/ShowDialogs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SignInPage extends StatelessWidget {
  GlobalKey<FormState> emailKey = GlobalKey<FormState>();

  TextEditingController emailCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  TextEditingController passwordAgainCtr = TextEditingController();

  List emails = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<DocumentSnapshot>(
        future: SignInPageModelView().getEmailListFromApi(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            emails = data['emails'];
            print(emails);
            return Scaffold(
              backgroundColor: Color(0xFFFFAC1C),
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Form(
                    key: emailKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Hero(
                          tag: 'mainIcon',
                          child: Image.asset(
                            'assets/autoImage.png',
                            width: size.width / 2,
                            height: size.width / 2,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Create Account ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50.0),
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: TextFormField(
                            controller: emailCtr,
                            validator: (_val) {
                              if (!EmailValidator.validate(_val!)) {
                                return 'Please enter valid email address';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.5),
                                prefixIcon: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: const Icon(Icons.email_outlined)),
                                hintText: 'Email',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(50.0))),
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        ///password
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: TextFormField(
                            controller: passwordCtr,
                            validator: (_val) {
                              if (_val!.length < 6) {
                                return 'please longer password';
                              }
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.5),
                                prefixIcon: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: const Icon(Icons.lock_outlined)),
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(50.0))),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: TextFormField(
                            controller: passwordAgainCtr,
                            validator: (_val) {
                              if (_val!.length < 6) {
                                return 'please longer password';
                              }
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.5),
                                prefixIcon: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: const Icon(Icons.lock_outlined)),
                                hintText: 'Re - password',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(50.0))),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            primary: Colors.white.withOpacity(0.7),
                            fixedSize: const Size(150, 40),
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () async {
                            if (emailKey.currentState!.validate()) {
                              if (passwordCtr.text != passwordAgainCtr.text) {
                                await ShowDialogs().showingDialog(context,
                                    'Error', "You have to enter same password");
                              } else if (emails.contains(emailCtr.text)) {
                                await ShowDialogs().showingDialog(
                                    context, 'Error', 'There is this email');
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignInPage2(
                                              email: emailCtr.text,
                                              password: passwordCtr.text,
                                              allEmails: emails,
                                            )));
                                // try {
                                //   await Auth().createUserWithEmailAndPassword(
                                //       emailCtr.text, passwordCtr.text);
                                // } on FirebaseAuthException catch (e) {
                                //   if (e.code == 'email-already-in-use') {
                                //     await ShowDialogs().showingDialog(context,
                                //         'Error', 'This email is already used.');
                                //   }
                                // } catch (e) {
                                //   print(e);
                                // }
                                // print('cont Sign In');
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => OnBoard()));
                              }
                            }
                          },
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          if (emails.isNotEmpty) {
            return Scaffold(
              backgroundColor: Color(0xFFFFAC1C),
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Form(
                    key: emailKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Hero(
                          tag: 'mainIcon',
                          child: Image.asset(
                            'assets/autoImage.png',
                            width: size.width / 2,
                            height: size.width / 2,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Create Account ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50.0),
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: TextFormField(
                            controller: emailCtr,
                            validator: (_val) {
                              if (!EmailValidator.validate(_val!)) {
                                return 'Please enter valid email address';
                              }
                              return null;
                            },
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.5),
                                suffixIcon: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: const Icon(Icons.email_outlined)),
                                hintText: '*************@gmail.com',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(50.0))),
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        ///password
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: TextFormField(
                            controller: passwordCtr,
                            validator: (_val) {
                              if (_val!.length < 6) {
                                return 'please longer password';
                              }
                            },
                            obscureText: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.5),
                                suffixIcon: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: const Icon(Icons.lock_outlined)),
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(50.0))),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: TextFormField(
                            controller: passwordAgainCtr,
                            validator: (_val) {
                              if (_val!.length < 6) {
                                return 'please longer password';
                              }
                            },
                            obscureText: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.5),
                                suffixIcon: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: const Icon(Icons.lock_outlined)),
                                hintText: 'Password Again',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(50.0))),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            primary: Colors.white.withOpacity(0.7),
                            fixedSize: const Size(150, 40),
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () async {
                            if (emailKey.currentState!.validate()) {
                              if (passwordCtr.text != passwordAgainCtr.text) {
                                await ShowDialogs().showingDialog(context,
                                    'Error', "You have to enter same password");
                              } else if (emails.contains(emailCtr.text)) {
                                await ShowDialogs().showingDialog(
                                    context, 'Error', 'There is this email');
                              } else {
                                try {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignInPage2(
                                                email: emailCtr.text,
                                                password: passwordCtr.text,
                                                allEmails: emails,
                                              )));
                                  // await Auth().createUserWithEmailAndPassword(
                                  //     emailCtr.text, passwordCtr.text);
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'email-already-in-use') {
                                    await ShowDialogs().showingDialog(context,
                                        'Error', 'This email is already used.');
                                  }
                                } catch (e) {
                                  print(e);
                                }
                                print('cont Sign In');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OnBoard()));
                              }
                            }
                          },
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        });
  }
}
