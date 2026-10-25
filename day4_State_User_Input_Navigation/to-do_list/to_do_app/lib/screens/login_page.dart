import 'package:flutter/material.dart';

// import 'package:to_do_app/screens/todo_screen.dart';
import 'dashboard.dart';

// import 'screens/todo_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<StatefulWidget> createState() => _signupScreenState();
}

class _signupScreenState extends State<SignupScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final emailRegex = RegExp(r'^[\w.-]+@[\w.-]+\.[a-zA-Z]{2,}$');
  String showEmail = "";
  bool isPassword = true;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    showEmail = emailController.text;
    return Scaffold(
      backgroundColor: const Color.from(
        alpha: 1,
        red: 0.757,
        green: 0.863,
        blue: 0.91,
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 104, 137, 154),
        title: Text(
          "Login Form",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Login Here",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 40),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "abc@tarseel.com",
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return "Email should not be empty";
                  }
                  if (!emailRegex.hasMatch(value.trim())) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: isPassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "password",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null) {
                    return "Password should not be empty";
                  }
                  if (passwordController.text.length < 6) {
                    return "Password must be 6 characters";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainDashboardScreen(showEmail: emailController.text,),
                      ),
                    );
                  }
                },
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
