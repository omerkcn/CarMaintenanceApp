import 'package:car_services_app/models/email.dart';
import 'package:car_services_app/on_board.dart';
import 'package:car_services_app/screens/home_page_components/main_page.dart';
import 'package:car_services_app/screens/sign_in_page.dart';
import 'package:car_services_app/services/auth.dart';
import 'package:car_services_app/services/local_db.dart';
import 'package:car_services_app/widgets/ShowDialogs.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> emailKey = GlobalKey<FormState>();

  TextEditingController emailCtr = TextEditingController();

  TextEditingController passwordCtr = TextEditingController();

  late List<Email> emails;

  bool isLoading = false;

  Future addEmail() async {
    final email = Email(
      email: emailCtr.text,
    );

    await EmailDatabase.instance.create(email);
  }

  List showEmailInTextField(String? query) {
    List emailInString = emails.map((email) => email.email).toList();
    return emailInString.where((email) => email.contains(query!)).toList();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.emails = await EmailDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    EmailDatabase.instance.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFFFAC1C),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: emailKey,
            child: Column(
              children: <Widget>[
                Hero(
                  tag: 'mainIcon',
                  child: Image.asset(
                    'assets/autoImage.png',
                    width: size.width / 2,
                    height: size.width / 2,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: const <TextSpan>[
                      TextSpan(
                        text: 'Have Some \nproblems with\n',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      TextSpan(
                          text: 'your car?',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              decoration: TextDecoration.none)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  // child: TextFormField(
                  //   controller: emailCtr,
                  //   validator: (_val) {
                  //     if (!EmailValidator.validate(_val!)) {
                  //       return 'Please enter valid email address';
                  //     }
                  //     return null;
                  //   },
                  //   textAlign: TextAlign.center,
                  //   decoration: InputDecoration(
                  //       filled: true,
                  //       fillColor: Colors.white.withOpacity(0.50),
                  //       suffixIcon: Container(
                  //           margin: const EdgeInsets.symmetric(horizontal: 25),
                  //           child: const Icon(Icons.email_outlined)),
                  //       hintText: '************@gmail.com',
                  //       border: OutlineInputBorder(
                  //           borderSide: BorderSide.none,
                  //           borderRadius: BorderRadius.circular(50.0))),
                  // ),
                  child: TypeAheadFormField<dynamic>(
                    validator: (_val) {
                      if (!EmailValidator.validate(_val!)) {
                        return 'Please enter valid email address';
                      }
                    },
                    textFieldConfiguration: TextFieldConfiguration(
                      textAlign: TextAlign.center,
                      controller: emailCtr,
                      // onChanged: (_) {
                      //   isModelSelect = false;
                      // },
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.50),
                          suffixIcon: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: const Icon(Icons.email_outlined)),
                          hintText: 'Email',
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50.0))),
                    ),
                    // suggestionsBoxDecoration: SuggestionsBoxDecoration(
                    //   borderRadius: BorderRadius.circular(24),
                    // ),
                    suggestionsCallback: showEmailInTextField,
                    itemBuilder: (context, dynamic suggestion) => ListTile(
                      title: Text(suggestion!),
                    ),
                    onSuggestionSelected: (dynamic suggestion) {
                      setState(() {
                        emailCtr.text = suggestion!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: TextFormField(
                    controller: passwordCtr,
                    validator: (_val) {
                      if (_val!.length < 6) {
                        return 'Please enter longer password';
                      }
                      return null;
                    },
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.50),
                        suffixIcon: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            child: Icon(Icons.lock_outlined)),
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50.0))),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (emailKey.currentState!.validate()) {
                      try {
                        await Auth().signInWithEmailAndPassword(
                            emailCtr.text, passwordCtr.text);
                        print('OnBoard a gidiliyor');
                        addEmail();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => OnBoard()));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          await ShowDialogs().showingDialog(
                              context, 'Error', 'User not found');
                        } else if (e.code == 'wrong-password') {
                          await ShowDialogs().showingDialog(
                              context, 'Error', 'Wrong Password');
                        }
                      }

                      print('log in button');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white.withOpacity(0.7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      fixedSize: const Size(150, 40)),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('or'),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignInPage()));
                  },
                  child: const Text(
                    'SIGN UP',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
