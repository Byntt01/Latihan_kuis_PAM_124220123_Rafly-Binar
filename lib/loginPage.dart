import 'package:flutter/material.dart';
import 'package:latihanresponsi/hiveDatabase.dart';
import 'package:latihanresponsi/menu_utama.dart';
import 'signUpPage.dart';
import '../dataModel.dart';

class LoginPageFul extends StatefulWidget {
  const LoginPageFul({Key? key}) : super(key: key);

  @override
  _LoginPageFulState createState() => _LoginPageFulState();
}

class _LoginPageFulState extends State<LoginPageFul> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void validateAndSave() {
    final FormState? form = _formKey.currentState;
    if (form != null) {
      if (form.validate()) {
        print('Form is valid');
      } else {
        print('Form is invalid');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],  // Latar belakang biru muda
      body: Container(
        padding: EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/image/albert.png', 
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 40),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: "Username",
                  hintStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Username cannot be blank' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? 'Password cannot be blank' : null,
              ),
              SizedBox(height: 30),
              _buildLoginButton(),
              SizedBox(height: 15),
              _buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _commonSubmitButton({
    required String labelButton,
    required Function(String) submitCallback,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,  // Warna biru untuk tombol
          padding: EdgeInsets.all(14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          labelButton,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          submitCallback(labelButton);
        },
      ),
    );
  }

  Widget _buildLoginButton() {
    return _commonSubmitButton(
      labelButton: "Login",
      submitCallback: (value) {
        validateAndSave();
        String currentUsername = _usernameController.value.text;
        String currentPassword = _passwordController.value.text;

        _processLogin(currentUsername, currentPassword);
      },
    );
  }

  void _processLogin(String username, String password) async {
    final HiveDatabase _hive = HiveDatabase();
    bool found = false;

    print('Username: $username');
    print('Password: $password');
    print('Encrypted Password: ${DataModel.encryptPassword(password)}');

    found = _hive.checkLogin(username, password);

    if (!found) {
      showAlertDialog(context);
    } else {
      print('Login successful!');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MenuUtama(),
        ),
      );

      SnackBar snackBar = SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green, // Hijau untuk sukses login
        content: Text("Login Success!", style: TextStyle(fontFamily: 'Montserrat')),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Widget _buildRegisterButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(width: 5),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SignUp(),
                ),
              );
            },
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(
        "Login Failed!",
        style: TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w600, color: Colors.red),
      ),
      content: Text(
        "Your account is not found",
        style: TextStyle(color: Colors.red),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
