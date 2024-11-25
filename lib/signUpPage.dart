import 'package:flutter/material.dart';
import 'package:latihanresponsi/hiveDatabase.dart';
import 'package:latihanresponsi/dataModel.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final HiveDatabase _hive = HiveDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],  // Latar belakang biru muda
      appBar: AppBar(
        title: const Text(
          "Register Your Account",
          style: TextStyle(
            fontFamily: "Montserrat",
            color:Colors.blue,// Red title color
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.blue, // Red back icon
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(32),  // Lebih banyak padding untuk tampilan yang lebih bersih
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
              validator: (String? value) {
                if (value!.trim().isEmpty) {
                  return 'Username is required';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
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
              validator: (String? value) {
                if (value!.trim().isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
            ),
            SizedBox(height: 30),
            _buildRegisterButton(),
          ],
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
          backgroundColor: Colors.blue,  // Red button color
          padding: EdgeInsets.all(14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
        ),
        child: Text(
          labelButton,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.white, // White text color
          ),
        ),
        onPressed: () {
          submitCallback(labelButton);
        },
      ),
    );
  }

  Widget _buildRegisterButton() {
    return _commonSubmitButton(
      labelButton: "Sign Up",
      submitCallback: (value) {
        if (_usernameController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty) {
          var encryptedPassword =
              DataModel.encryptPassword(_passwordController.text);

          print('Username: ${_usernameController.text}');
          print('Password: ${_passwordController.text}');
          print('Encrypted Password: $encryptedPassword');

          _hive.addData(
            DataModel(
              username: _usernameController.text,
              password: _passwordController.text,
              encryptedPassword: encryptedPassword,
            ),
          );

          _usernameController.clear();
          _passwordController.clear();

          setState(() {});

          Navigator.pop(context);
        }
      },
    );
  }
}
