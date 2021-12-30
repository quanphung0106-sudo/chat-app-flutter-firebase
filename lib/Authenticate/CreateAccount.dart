
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Screens/HomeScreen.dart';
import 'Methods.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final firsNameField = TextFormField(
      autofocus: false,
      controller: _name,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{2,}$');
        if (value!.isEmpty) {
          return ("Tên không được để trống");
        }
        if (!regex.hasMatch(value)) {
          return ("Vui lòng nhập tên hợp lệ (Tối thiểu 2 kí tự)");
        }
        return null;
      },
      onSaved: (value) {
        _name.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(12, 15, 20, 15),
          hintText: "FirstName",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final emailField = TextFormField(
      autofocus: false,
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Vui lòng nhập email của bạn");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Vui lòng nhập email hợp lệ");
        }
        ;
        return null;
      },
      onSaved: (value) {
        _email.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          contentPadding: EdgeInsets.fromLTRB(12, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: _password,
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Mật khẩu không được để trống");
        }
        if (!regex.hasMatch(value)) {
          return ("Vui lòng nhập mật khẩu hợp lệ (tối thiểu 6 kí tự)");
        }
      },
      onSaved: (value) {
        _password.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(12, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final confirmpasswordField = TextFormField(
      autofocus: false,
      controller: _confirmPassword,
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (_confirmPassword.text != _password.text) {
          return ("Password don't match");
        }
      },
      onSaved: (value) {
        _confirmPassword.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(12, 15, 20, 15),
          hintText: "ConfirmPassword",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(12, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(_email.text, _password.text);
        },
        child: Text(
          "SignUp",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.red,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: isLoading
          ? Center(
        child: Container(
          height: size.height / 20,
          width: size.height / 20,
          child: CircularProgressIndicator(),
        ),
      )
          : SingleChildScrollView(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200,
                        child: Image.asset(
                          "assets/logo.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      firsNameField,
                      SizedBox(
                        height: 20,
                      ),
                      emailField,
                      SizedBox(
                        height: 20,
                      ),
                      passwordField,
                      SizedBox(
                        height: 20,
                      ),
                      confirmpasswordField,
                      SizedBox(
                        height: 20,
                      ),
                      signupButton,
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (formKey.currentState!.validate()) {
      createAccount(_name.text, _email.text, _password.text).then((user) {
        if (user != null) {
          setState(() {
            isLoading = false;
          });
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => HomeScreen()));
          Fluttertoast.showToast(msg: "Tài khoản được tạo thành công!");
        } else {
          Fluttertoast.showToast(
              msg: "Lỗi mất rồi! Hình như gmail này đã được tạo rồi :((");
          setState(() {
            isLoading = false;
          });
        }
      });
    } else {
      Fluttertoast.showToast(msg: "Làm ơn nhập đầy đúng đi anh bạn :((");
    }
  }
}
