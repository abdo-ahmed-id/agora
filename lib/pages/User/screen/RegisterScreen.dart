// ignore_for_file: file_names, must_be_immutable

import 'package:agoratestapp/pages/User/logic/user_api.dart';
import 'package:agoratestapp/pages/User/model/usermodel.dart';
import 'package:agoratestapp/pages/User/screen/contact_list_page.dart';
import 'package:agoratestapp/shared/shared_widgets/CustomBottun.dart';
import 'package:agoratestapp/shared/shared_widgets/CustomTextField.dart';
import 'package:agoratestapp/shared/shared_theme/constants.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  List<UserModel> model = [];

  @override
  void initState() {
    fetchData(model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(height: 50),
              Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIQHQvz86_f9hE8Hxk-JmrWYPzcjiuwds23g&usqp=CAU',
                height: 200,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Deaf Video Call',
                  style: TextStyle(
                    fontSize: 32,
                    color: secondryColor,
                    fontFamily: 'pacifico',
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Row(
                children: const [
                  Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 24,
                      color: secondryColor,
                      fontFamily: 'pacifico',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller: nameController,
                  hintText: 'Name',
                  validator: () => null),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                  controller: phoneController,
                  hintText: 'Phone',
                  validator: () => null),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: emailController,
                hintText: 'Email',
                validator: () {
                  if (emailController.text.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  if (!emailController.text.contains("@") ||
                      !emailController.text.contains(".com")) {
                    return 'Invalid email';
                  }
                  for (var element in model) {
                    if (element.email.contains(emailController.text)) {
                      return 'email already been used';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                validator: () {
                  if (passwordController.text.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  return null;
                },
                controller: passwordController,
                hintText: 'Password',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                  text: "Sign Up",
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (formKey.currentState!.validate()) {
                      sendUserData(
                          emailController.text,
                          passwordController.text,
                          nameController.text,
                          phoneController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const ContactListPage())));
                    }
                  }
                  // async {
                  //   var auth = FirebaseAuth.instance;
                  //   UserCredential user = await auth.createUserWithEmailAndPassword(
                  //       email: email!, password: password!);
                  // },
                  ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?  ",
                    style: TextStyle(color: secondryColor),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: secondryColor),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
