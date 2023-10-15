import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/Navbar.dart';
import '../widgets/widgets.dart';
import 'add_sr.dart';

class User {
  final String name;
  final String email;
  final String profilePicture;

  User({
    required this.name,
    required this.email,
    required this.profilePicture,
  });
}

getuserdata() async {
  List<User> users = [];
  CollectionReference usersdata = FirebaseFirestore.instance.collection('user');
  QuerySnapshot querySnapshot = await usersdata.get();
  for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    if (data != null) {
      final String? name = data['name'] as String?;
      final String? email = data['email'] as String?;
      final String? profilepic = data['profile'] as String?;

      if (name != null && email != null && profilepic != null) {
        users.add(
          User(
            name: name,
            email: email,
            profilePicture: profilepic,
          ),
        );
      }
    }
  }
  return users;
}

class Sr_list extends StatefulWidget {
  @override
  State<Sr_list> createState() => _Sr_listState();
}

class _Sr_listState extends State<Sr_list> {
  @override
  List<User> users = [];

  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    List<User> loadedUsers = await getuserdata();
    setState(() {
      users = loadedUsers;
    });
  }
  //  List<User> users = [
  //   User(
  //     name: 'John Doe',
  //     email: 'john@example.com',
  //     profilePicture: 'assets/img/profile.jpg',
  //   ),
  //   User(
  //     name: 'Jane Smith',
  //     email: 'jane@example.com',
  //     profilePicture: 'assets/img/profile.jpg',
  //   ),
  //   // Add more users here
  // ];

  @override
  Widget build(BuildContext context) {
    var primarycolor = Color(0xff3553C0);
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: navbar(),
      appBar:  appbar,
      body: Column(
        children: [
          Expanded(
            child: UserList(users: users),
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add_sr');
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

class UserList extends StatelessWidget {
  final List<User> users;

  UserList({required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return UserCard(user: users[index]);
      },
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;

  UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      elevation: 4.0,
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.profilePicture),
        ),
        title: Text(user.name),
        subtitle: Text(user.email),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 28,
              margin: EdgeInsets.only(top: 0.0, bottom: 0.0),
              child: IconButton(
                icon: Icon(Icons.edit),
                iconSize: 22.0,
                onPressed: () {
                  // Add edit action here
                },
              ),
            ),
            Container(
              height: 28,
              margin: EdgeInsets.only(top: 0.0, bottom: 0.0),
              child: IconButton(
                icon: Icon(Icons.delete),
                iconSize: 21.0,
                onPressed: () {
                  // Add delete action here
                },
              ),
            ),
          ],
        ),
        onTap: () {
          // Add navigation or action when a user is tapped
          // For example, navigate to a detailed user profile page
        },
      ),
    );
  }
}

class AddUserButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_sr');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
