import 'package:flutter/material.dart';
import 'package:travel_budget/widgets/provider_widget.dart';
import 'package:intl/intl.dart';
import 'package:travel_budget/models/User.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  User user = User("");
  bool _isAdmin = false;
  TextEditingController _userCountryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: Provider.of(context).auth.getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return displayUserInformation(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget displayUserInformation(context, snapshot) {
    final authData = snapshot.data;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Provider.of(context).auth.getProfileImage(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Name: ${authData.displayName ?? 'Anonymous'}",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Email: ${authData.email ?? 'Anonymous'}",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Created: ${DateFormat('MM/dd/yyyy').format(authData.metadata.creationTime)}",
            style: TextStyle(fontSize: 20),
          ),
        ),
        FutureBuilder(
          future: _getProfileData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              _userCountryController.text = user.homeCountry;
              _isAdmin = user.admin ?? false;
            }
            return Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Home Country: ${_userCountryController.text}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  adminFeature(),
                ],
              ),
            );
          }
        ),
        showSignOut(context, authData.isAnonymous),
        ElevatedButton(
          child: Text("Edit User"),
          onPressed: () {
            _userEditBottomSheet(context);
          },
        )
      ],
    );
  }

  _getProfileData() async {
    final uid = Provider.of(context).auth.getCurrentUID();
    await Provider.of(context)
        .db
        .collection('userData')
        .document(uid)
        .get().then((result) {
          user.homeCountry = result.data['homeCountry'];
          user.admin = result.data['admin'];
    });
  }

  Widget showSignOut(context, bool isAnonymous) {
    if (isAnonymous == true) {
      return ElevatedButton(
        child: Text("Sign In To Save Your Data"),
        onPressed: () {
          Navigator.of(context).pushNamed('/convertUser');
        },
      );
    } else {
      return ElevatedButton(
        child: Text("Sign Out"),
        onPressed: () {
          try {
            Provider.of(context).auth.signOut();
          } catch (e) {
            print(e);
          }
        },
      );
    }
  }

  Widget adminFeature() {
    if(_isAdmin == true) {
      return Text("You are an admin");
    } else {
      return Container();
    }
  }

  void _userEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .60,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 15.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Update Profile"),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      color: Colors.orange,
                      iconSize: 25,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: TextField(
                          controller: _userCountryController,
                          decoration: InputDecoration(
                            helperText: "Home Country",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      child: Text('Save', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () async {
                        user.homeCountry = _userCountryController.text;
                        setState(() {
                          _userCountryController.text = user.homeCountry;
                        });
                        final uid =
                            Provider.of(context).auth.getCurrentUID();
                        await Provider.of(context)
                            .db
                            .collection('userData')
                            .document(uid)
                            .setData(user.toJson());
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
