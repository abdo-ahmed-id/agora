import 'package:agoratestapp/pages/User/logic/user_api.dart';
import 'package:agoratestapp/pages/User/model/usermodel.dart';
import 'package:agoratestapp/shared/shared_widgets/CustomBottun.dart';
import 'package:agoratestapp/shared/shared_widgets/CustomTextField.dart';
import 'package:agoratestapp/pages/LogsPage.dart';
import 'package:agoratestapp/pages/User/screen/RegisterScreen.dart';
import 'package:agoratestapp/pages/User/screen/contact_list_page.dart';
import 'package:flutter/material.dart';
import '../../../shared/shared_theme/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static String id = 'LoginPage';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Deaf Video Call',
                    style: TextStyle(
                      fontSize: 32,
                      color: secondryColor,
                      fontFamily: 'pacifico',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Row(
                children: const [
                  Text(
                    'LOGIN',
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
                controller: emailController,
                hintText: 'Email',
                textType: TextInputType.emailAddress,
                validator: () {
                  if (emailController.text.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  if (!emailController.text.contains("@") ||
                      !emailController.text.contains(".com")) {
                    return 'Invalid email';
                  }
                  for (var element in model) {
                    if (element.email.contains(emailController.text) ||
                        element.password.contains(passwordController.text)) {
                      return null;
                    }
                  }
                  return 'Incorrect email or password';
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: passwordController,
                hintText: 'Password',
                validator: () {
                  if (passwordController.text.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                text: "Login",
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();

                  if (formKey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ContactListPage()));
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "don't have an account?  ",
                    style: TextStyle(color: secondryColor),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ));
                    },
                    child: const Text(
                      "SignUp",
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
