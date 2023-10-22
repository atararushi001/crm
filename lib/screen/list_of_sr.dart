import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/Navbar.dart';
import '../widgets/widgets.dart';
import 'add_sr.dart';

typedef void VoidCallback();

getuserdata() async {
  List<Map> users = [];
  CollectionReference usersdata = FirebaseFirestore.instance.collection('user');
  QuerySnapshot querySnapshot = await usersdata.get();
  for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    if (data != null) {
      final String? uid = data['user_uid'] as String?;
      final String? name = data['name'] as String?;
      final String? email = data['email'] as String?;
      final String? profilepic = data['profile'] as String?;

      if (name != null && email != null && profilepic != null && uid != null) {
        users.add(data);
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
  List<Map> users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    List<Map> loadedUsers = await getuserdata();
    setState(() {
      users = loadedUsers;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: navbar(),
      appBar: appbar,
      body: _isLoading
          ? buildLoadingIndicator()
          : Column(
        children: [
          Expanded(
            child: UserList(users: users, onUserDelete: _loadUserData),
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
  final List<Map> users;
  final VoidCallback onUserDelete;

  UserList({required this.users, required this.onUserDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return UserCard(user: users[index], onDelete: onUserDelete);
      },
    );
  }
}

class UserCard extends StatelessWidget {
  final Map user;
  final VoidCallback onDelete;

  UserCard({required this.user, required this.onDelete});

  void _deleteUser(BuildContext context) {
    String userUid = user['user_uid'];
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('user');

    usersCollection
        .where('user_uid', isEqualTo: userUid)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete().then((value) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('SR deleted successfully'),
          ));

          // Call the onDelete callback to reload user data
          onDelete();
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error deleting SR: $error'),
          ));
        });
      });
    });
  }

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
          backgroundImage: NetworkImage(user['profile']),
        ),
        title: Text(user['name']),
        subtitle: Text(user['email']),
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
                  Navigator.pushNamed(context, '/add_sr', arguments: user);
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
                  _deleteUser(context);
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
