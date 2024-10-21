import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';

class ChatBubbles extends StatelessWidget {
  final String _message;
  final bool _isMe;
  final String _userName;
  final String? _userImageUrl;

  const ChatBubbles(
    this._message,
    this._isMe,
    this._userName,
    this._userImageUrl, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Stack(
        children: [
          Padding(
            padding: _isMe ? const EdgeInsets.fromLTRB(0, 10, 40, 0) : const EdgeInsets.fromLTRB(40, 10, 0, 0),
            child: Row(
              mainAxisAlignment: _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                if (_isMe)
                ChatBubble(
                  clipper: ChatBubbleClipper8(type: BubbleType.sendBubble),
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(top: 20),
                  backGroundColor: Colors.blue,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _userName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          _message,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!_isMe)
                ChatBubble(
                  clipper: ChatBubbleClipper8(type: BubbleType.receiverBubble),
                  backGroundColor: Color(0xffE7E7ED),
                  margin: EdgeInsets.only(top: 20),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _userName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          _message,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: _isMe ? 5 : null,
            left: _isMe ? null : 5,
            child: CircleAvatar(
              backgroundImage: _userImageUrl != null ? NetworkImage(_userImageUrl) : null,
            ),
          ),
        ]
      ),
    );
  }
}
