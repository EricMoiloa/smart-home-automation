import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smartlife/Api%20services/login_api.dart';

import 'login_screen.dart';

class RegScreen extends StatefulWidget {
  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  final LoginApiServices _apiService = LoginApiServices();

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xffA7A7A7),
                Color(0xffFAFAFA),
              ]),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 40.0, left: 22),
              child: Text(
                'Create Your\nAccount',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 140.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color:
                                              Color.fromARGB(63, 124, 124, 124),
                                        ),
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Full Names",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400]),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color:
                                              Color.fromARGB(63, 124, 124, 124),
                                        ),
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email or Phone Number",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400]),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your email or phone number';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color:
                                              Color.fromARGB(63, 124, 124, 124),
                                        ),
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: _passwordController,
                                      obscureText: _isHidden,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400]),
                                        suffix: InkWell(
                                          onTap: _togglePasswordView,
                                          child: Icon(
                                            _isHidden
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: _confirmPasswordController,
                                      obscureText: _isHidden,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Confirm Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400]),
                                        suffix: InkWell(
                                          onTap: _togglePasswordView,
                                          child: Icon(
                                            _isHidden
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please confirm your password';
                                        } else if (value !=
                                            _passwordController.text) {
                                          return 'Passwords do not match';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  // Perform registration logic here
                                  final response = await _apiService.createUser(
                                    _nameController.text,
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                                  print(response.statusCode);
                                  if (response.statusCode == 201) {
                                    // Registration successful, navigate to login screen
                                    Get.offAll(() => const LoginScreen());
                                  } else {
                                    // Registration failed, show error message
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => Container(
                                        padding: const EdgeInsets.all(16),
                                        child: Text(
                                          'Registration failed: ${response.body}',
                                          style: const TextStyle(
                                              color: Colors.red),
                                        ),
                                      ),
                                    );
                                  }

                                  print('Name: ${_nameController.text}');
                                  print('Email: ${_emailController.text}');
                                  print(
                                      'Password: ${_passwordController.text}');
                                }
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xffA7A7A7),
                                      Color(0xffA7A7A7),
                                    ],
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Forgot Your Password?",
                                  style: TextStyle(
                                    color: Color(0xffA7A7A7),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Already have an account?",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen()));
                                      },
                                      child: Text(
                                        "Sign In",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
