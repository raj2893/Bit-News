import 'package:flutter/material.dart';
import 'package:bitnews/pages/CategoryPage.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //created a form with email and password fields with the validator set on the email
              //field to check if the email is valid

              //Text displaying BitNews

              Center(
                child: Text(
                  "Bit News",
                  style: GoogleFonts.kaushanScript(
                      fontSize: 40, fontWeight: FontWeight.w900),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              //email field
              FractionallySizedBox(
                widthFactor: 0.7,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 161, 161, 161)),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      } else if (!value.contains("@")) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //password field
              FractionallySizedBox(
                widthFactor: 0.7,
                child: Form(
                  key: _passKey,
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 161, 161, 161)),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      } else if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //login button
              FractionallySizedBox(
                widthFactor: 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        _passKey.currentState!.validate()) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectionOptionsPage()));
                    }
                  },
                  child: Text("Login"),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
