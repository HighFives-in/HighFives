import 'package:flutter/material.dart';
import 'package:highfives_ui/constants/const/business.dart';
import 'package:highfives_ui/constants/const/errors.dart';
import 'package:highfives_ui/resources/Identity/main.dart';
import 'package:highfives_ui/screens/employer/dashboard/employerDashboard.dart';
import 'package:highfives_ui/screens/employer/profile/employer_profile.dart';
import 'package:highfives_ui/screens/login/roleChanger.dart';
import 'package:highfives_ui/screens/tnp/dashboard/tnpdashboard.dart';
import 'package:highfives_ui/screens/utils/loading.dart';
import 'package:highfives_ui/utils/platform.dart';
import 'package:highfives_ui/utils/responsiveLayout.dart';
import 'package:highfives_ui/utils/toast.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';

class SignupLogic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RoleChanger(STUDENT, 1),
      child: SignupLogicWithRole(),
    );
  }
}

class SignupLogicWithRole extends StatelessWidget {
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _selectedRole;
  final TextEditingController _pass = TextEditingController();

  //TODO CORRECT ?
  final _identityResource = IdentityResource(findPlatform());
  @override
  Widget build(BuildContext context) {
    _selectedRole = Provider.of<RoleChanger>(context).role;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Email', style: Theme.of(context).textTheme.headline4),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: FractionallySizedBox(
              widthFactor: ResponsiveLayout.isLargeScreen(context) ? 0.67 : 1,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.3),
                  border: Border.all(
                      color: Theme.of(context).accentColor, width: 0.83),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value.isEmpty) return 'Please Enter Email !';
                        return null;
                      },
                      onSaved: (value) {
                        _email = value;
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child:
                Text('Password', style: Theme.of(context).textTheme.headline4),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: FractionallySizedBox(
              widthFactor: ResponsiveLayout.isLargeScreen(context) ? 0.67 : 1,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.3),
                  border: Border.all(
                      color: Theme.of(context).accentColor, width: 0.83),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: _pass,
                      validator: (value) {
                        if (value.isEmpty || value.length <= 6)
                          return 'Password too short!';
                        return null;
                      },
                      onSaved: (value) {
                        _password = value;
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Confirm password',
                style: Theme.of(context).textTheme.headline4),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: FractionallySizedBox(
              widthFactor: ResponsiveLayout.isLargeScreen(context) ? 0.67 : 1,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.3),
                  border: Border.all(
                      color: Theme.of(context).accentColor, width: 0.83),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value.isEmpty) return 'Empty';
                          if (value != _pass.text) {
                            return 'Password doesn\'t match';
                          }
                          return null;
                        }),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          RoleWithRadioButtons(),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: 130,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: FlatButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    try {
                      dynamic res = await locator<Loading>().handleSubmit(
                          context,
                          this._attemptSignUp(
                              _email, _password, _selectedRole));
                      if (res == null || !res) {
                        basicErrorFlutterToast(SIGNUP_ERROR);
                      } else if (res != null && res) {
                        _formKey.currentState.reset();
                        navigateToHome(_selectedRole, context);
                      }
                    } catch (e) {
                      basicErrorFlutterToast(SIGNUP_SERVICE_DOWN);
                    }
                  }
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text('Sign Up',
                      style: Theme.of(context).textTheme.headline5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToHome(String role, BuildContext context) {
    switch (role) {
      case STUDENT:
        //TODO NOT IMPLEMENTED YET !!
        // Navigator.pushNamed(context, '/' + TnpView.tnpMainRoute);
        Navigator.pushReplacementNamed(context, '/' + TnpView.tnpMainRoute);
        break;
      case TNP:
        //TODO PUSHNAMED ?
        // Navigator.pushNamed(context, '/' + TnpView.tnpMainRoute);
        Navigator.pushReplacementNamed(context, '/' + TnpView.tnpMainRoute);
        break;
      case EMPLOYER:
        //TODO LIKE ABOVE ONE
        //TODO PUSHNAMED ?
        // Navigator.pushNamed(context, '/' + TnpView.tnpMainRoute);
        Navigator.pushReplacementNamed(
            context, '/' + EmployerView.employerMainRoute);
        break;
    }
  }

  Future<dynamic> _attemptSignUp(
      String email, String password, String role) async {
    return await _identityResource.signUp(email, password, role);
  }
}

class RoleWithRadioButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int _roleIndex = Provider.of<RoleChanger>(context).roleIndex;
    return Row(
      children: [
        Radio(
          activeColor: Theme.of(context).dividerColor,
          groupValue: _roleIndex,
          value: 1,
          onChanged: (t) {
            _roleIndex = t;
            Provider.of<RoleChanger>(context, listen: false)
                .setRole(STUDENT, 1);
          },
        ),
        Text(STUDENT, style: Theme.of(context).textTheme.headline6),
        Radio(
          activeColor: Theme.of(context).dividerColor,
          groupValue: _roleIndex,
          value: 3,
          onChanged: (t) {
            _roleIndex = t;
            Provider.of<RoleChanger>(context, listen: false)
                .setRole(EMPLOYER, 3);
          },
        ),
        Text(EMPLOYER, style: Theme.of(context).textTheme.headline6),
      ],
    );
  }
}