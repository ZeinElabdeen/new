
import 'package:flutter/material.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/BLoCs/chat_bloc.dart';

import '../img_upload_review.dart';

class ChatField extends StatefulWidget {
  @override
  _ChatFieldState createState() => _ChatFieldState();
}

class _ChatFieldState extends State<ChatField> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          InkWell(
            onTap: (){
              if(_controller.text.length == 0 ){
                return;
              }
              chatBloc.add(SendMsg());
              _controller.clear();
            },
            child: Material(
              shape: CircleBorder(),
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(11),
                child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Icon(Icons.send, color: Colors.white)),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: chatBloc.updateMsg,
              minLines: 1,
              maxLines: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ImageUploadReview())),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.transparent),
                      child: Icon(Icons.camera_alt),
                    ),
                  ),
                ),
                hintText: 'اكتب رساله...',
                contentPadding: EdgeInsets.only(
                    top: 5.0, right: 10.0, bottom: 5.0, left: 5.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
