import 'dart:io';

import 'package:flutter/material.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/BLoCs/chat_bloc.dart';
import 'package:haat/src/Screens/HomePages/Apis/Helpers/image_picker_dialog.dart';

class ImageUploadReview extends StatefulWidget {
  @override
  _ImageUploadReviewState createState() => _ImageUploadReviewState();
}

class _ImageUploadReviewState extends State<ImageUploadReview> {
  File _img;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ImagePickerDialog().show(
          context: context,
          onGet: (f) {
            chatBloc.updatePhoto(f);
            chatBloc.add(UploadPhoto());
            setState(() {
              _img = f;
            });
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          SizedBox(width: 20),
          InkWell(
            onTap: () {
              ImagePickerDialog().show(
                  context: context,
                  onGet: (f) {
                    chatBloc.updatePhoto(f);
                    chatBloc.add(UploadPhoto());
                    setState(() {
                      _img = f;
                    });
                  });
            },
            child: Icon(Icons.camera_alt, color: Colors.white),
          ),
          SizedBox(width: 20),
        ],
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          chatBloc.add(SendMsg());
          Navigator.pop(context);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Icon(Icons.send, color: Colors.white)),
      ),
      body: ListView(
        children: [
          _img != null
              ? Image.file(_img,
                  width: MediaQuery.of(context).size.width - 100,
                  height: MediaQuery.of(context).size.height - 300)
              : Container(),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: chatBloc.updateMsg,
              minLines: 1,
              maxLines: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'اكتب رساله...',
                contentPadding: EdgeInsets.only(
                    top: 5.0, right: 10.0, bottom: 5.0, left: 5.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
