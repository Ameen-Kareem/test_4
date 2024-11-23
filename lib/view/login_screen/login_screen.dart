import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_4/view/home_screen/home_screen.dart';
import 'package:test_4/view/register_screen/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String? username;
  String? password;
  bool hidePass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 30,
        ),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign in to Your Account",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //Email Input Field
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email cannot be empty";
                      } else if (!value.contains("@")) {
                        return "Invalid email";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Your Email Address",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  //Password Input field
                  TextFormField(
                    controller: passController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password cannot be empty";
                      } else if (value.length < 7 || value.length > 16) {
                        return "Password must be between 6-15 characters";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        hintText: "Your Password ",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            if (hidePass == true) {
                              hidePass = false;
                            } else {
                              hidePass = true;
                            }
                            setState(() {});
                          },
                          child: Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                          ),
                        )),
                    obscureText: hidePass,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.check_box_outlined,
                        color: Colors.grey,
                      ),
                      Text(
                        "Remember Me",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Text(
                        "Forgot Password",
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        username = await prefs.getString('user');
                        password = await prefs.getString('password');

                        //Checks if registered details if it exists matches the entered details

                        if (username == nameController.text &&
                            password == passController.text) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ));
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Text(
                                  "Account couldn't be found!\nMake sure you are already registered"),
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Sign in ",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 300,
                  ),
                  newUser(context)
                ],
              ),
            ),
          )),
    );
  }

  Widget newUser(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterScreen(),
                ));
          },
          child: Text(
            "Sign Up",
            style: TextStyle(color: Colors.blue),
          ),
        )
      ],
    );
  }
}
