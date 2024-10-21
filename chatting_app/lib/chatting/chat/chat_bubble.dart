import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String _message;
  final bool _isMe;

  const ChatBubble(
    this._message,
    this._isMe, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: _isMe ? Colors.grey[300] : Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: _isMe ? Radius.circular(12) : Radius.circular(0),
              bottomRight: _isMe ? Radius.circular(0) : Radius.circular(12),
            ),
          ),
          width: 145,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(
            _message,
            style: TextStyle(
              color: _isMe ? Colors.black : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
