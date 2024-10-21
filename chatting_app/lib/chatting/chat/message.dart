import 'package:chatting_app/chatting/chat/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
  
    return StreamBuilder(
      stream: FirebaseFirestore.instance
        .collection('chat')
        .orderBy('time', descending: true)
        .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final chatDocs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: chatDocs.length,
          itemBuilder: (context, index) {
            return ChatBubbles(
              chatDocs[index]['text'],
              chatDocs[index]['userId'].toString() == user!.uid,
              chatDocs[index]['userName'],
              chatDocs[index].data()['userImage'],
            );
          },
          reverse: true,
        );
      },
    );
  }
}
