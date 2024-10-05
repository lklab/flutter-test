import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  User? loggedUser;

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;

      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    }
    catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat screen'),
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.exit_to_app_sharp,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chats/pw4k8xBHPSCnF36EA0E4/message').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  docs[index]['text'],
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
