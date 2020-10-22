import 'package:flutter/material.dart';
import '../pickers/user_image_picker.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitfn, this.isLoading);
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    File image,
    BuildContext ctx,
  ) submitfn;
  final bool isLoading;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  File _userProfileImage;
  // String dropDownValue = 'House Owner';
  // final _passController = TextEditingController();

  void _trySubmit() {
    final isValid = _formkey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userProfileImage == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
            content: Text("Please Pick a Image!!"),
            backgroundColor: Theme.of(context).errorColor),
      );
      return;
    }

    if (isValid) {
      _formkey.currentState.save();
      widget.submitfn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
          _isLogin, _userProfileImage, context,);
    }
  }

  void _pickedImage(File image) {
    _userProfileImage = image;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        height: _isLogin ? 300 : 430,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        child: Card(
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) UserImagePicker(_pickedImage),
                  TextFormField(
                    key: ValueKey('email'),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    validator: (value) {
                      if (!value.contains('@') || value.isEmpty) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: "Email Address"),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      enableSuggestions: true,
                      decoration: InputDecoration(labelText: "Username"),
                      validator: (value) {
                        if (value.length < 4 || value.isEmpty) {
                          return "choose a username of altleast 4 charcters";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value.length < 7 || value.isEmpty) {
                        return "Password should be of length greater than 6";
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value;
                    },
                    // controller: _passController,
                  ),
             
                  SizedBox(
                    height: 12,
                  ),
                  // if (!_isLogin)
                  //   TextFormField(
                  //     key: ValueKey('password'),
                  //     validator: (value) {
                  //       if (value.length < 7 ||
                  //           value.isEmpty ||
                  //           _passController.text != value) {
                  //         return "Password not matching";
                  //       }
                  //       return null;
                  //     },
                  //     decoration:
                  //         InputDecoration(labelText: "Confirm Password"),
                  //     obscureText: true,
                  //     onSaved: (value) {
                  //       _userPassword = value;
                  //     },
                  //   ),
                  if (widget.isLoading)
                    Center(child: CircularProgressIndicator()),
                  if (!widget.isLoading)
                    RaisedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                    ),
                  SizedBox(
                    height: 12,
                  ),
                  if (!widget.isLoading)
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: widget.isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text(_isLogin
                              ? 'create New Account'
                              : 'I already have an account'),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
