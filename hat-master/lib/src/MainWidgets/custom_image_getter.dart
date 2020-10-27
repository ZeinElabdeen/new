import 'dart:io';

import 'package:flutter/material.dart';

class GetImage {
  Widget showMainImg(
      {BuildContext context,
      File mainImg,
      Function deleteImage,
      Widget cameraBtn}) {
    if (mainImg != null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Stack(
          children: <Widget>[
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    mainImg,
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              child: InkWell(
                onTap: deleteImage,
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 30,
                ),
              ),
              bottom: 10,
              left: 10,
            ),
          ],
        ),
      );
    } else {
      return cameraBtn;
    }
  }

  Widget buildPhoto(
      {BuildContext context,
      File image,
      Function deleteImage,
      Function addPhoto}) {
    return Stack(
      children: <Widget>[
        image == null
            ? InkWell(
                onTap: addPhoto,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey),
                    child: Center(
                      child: Text(
                        "اضف صورة للمجموعة",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                        image: Image.file(image).image, fit: BoxFit.cover)),
              ),
        image == null
            ? Container()
            : Positioned(
                child: InkWell(
                  onTap: deleteImage,
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
                bottom: 5,
                left: 5,
              ),
      ],
    );
  }
}
