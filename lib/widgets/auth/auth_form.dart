// import 'dart:ffi';
import 'dart:io';

import 'package:chat_app/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String username,
    File image,
    bool isLogin,
    BuildContext context,
  ) submitFn;
  final bool isloading;

  const AuthForm(this.submitFn, this.isloading);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

// add keys to all formfields or else value flows
class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userUsername = '';
  var _userPassword = '';
  File _userImageFile;

  void _pickedImage(File image) => _userImageFile = image;
  void _trySubmit() {
    final isvalid = _formkey.currentState.validate();
    FocusScope.of(context).unfocus(); //remove keyboard

    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
          const SnackBar(content: Text('Please Select An Image')));
      return;
    }

    if (isvalid) {
      _formkey.currentState.save();
      //sent auth req
      //usee .trim
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userUsername.trim(),
        _userImageFile,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          // controller: ,
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_isLogin) UserImagePicker(_pickedImage),
                TextFormField(
                  key: const ValueKey('email'),
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please Enter a valid Address';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _userEmail = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      const InputDecoration(label: Text('Email address')),
                ),
                if (!_isLogin)
                  TextFormField(
                    key: const ValueKey('username'),
                    decoration: const InputDecoration(label: Text('Username')),
                    validator: (value) {
                      if (value.isEmpty || value.length < 4) {
                        return 'username must be atleast 4 characters long';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _userUsername = value;
                    },
                  ),
                TextFormField(
                  key: const ValueKey('password'),
                  decoration: const InputDecoration(label: Text('Password')),
                  validator: (value) {
                    if (value.isEmpty || value.length < 6) {
                      return 'Password must be atleast 6 charectors long';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    _userPassword = value;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 12),
                if (widget.isloading) const CircularProgressIndicator(),
                if (!widget.isloading)
                  ElevatedButton(
                    onPressed: _trySubmit,
                    child: Text(_isLogin ? 'Login' : 'Sign Up'),
                  ),
                // if (widget.isloading)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(_isLogin
                      ? 'Create New Account'
                      : 'Already have an account? Login'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
