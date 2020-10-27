import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haat/src/Screens/HomePages/Apis/BLoCs/shared_bloc.dart';
import 'package:haat/src/Screens/HomePages/Apis/Helpers/text_helper.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/AppModels/msg_model.dart';

class MsgCard extends StatefulWidget {
  final MsgModel model;

  const MsgCard({Key key, this.model}) : super(key: key);

  @override
  _MsgCardState createState() => _MsgCardState();
}

class _MsgCardState extends State<MsgCard> {
  @override
  Widget build(BuildContext context) {
    if (sharedBloc.data.id == widget.model.userId) {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 40,
                width: 40,
                child: CachedNetworkImage(
                  imageUrl: widget.model.userPhoto ?? "",
                  fadeInDuration: Duration(seconds: 2),
                  placeholder: (context, url) => CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/avatar.jpeg')),
                  imageBuilder: (context, provider) {
                    return CircleAvatar(radius: 60, backgroundImage: provider);
                  },
                ),
              ),
              Expanded(
                child: Bubble(
                  margin: BubbleEdges.all(1),
                  nip: BubbleNip.rightBottom,
                  color: Theme.of(context).primaryColor.withOpacity(.2),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Text(widget.model.message ?? "",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.white)),
                      widget.model.file != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                widget.model.file,
                                height: 200,
                              ),
                            )
                          : Container(),
                      widget.model.latitude != null
                          ? Container(
                              height: 200,
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                      double.parse(widget.model.latitude),
                                      double.parse(widget.model.longitude)),
                                  zoom: 14.0,
                                ),
                                gestureRecognizers:
                                    <Factory<OneSequenceGestureRecognizer>>[
                                  new Factory<OneSequenceGestureRecognizer>(
                                    () => new EagerGestureRecognizer(),
                                  ),
                                ].toSet(),
                              ),
                            )
                          : Container(),
                      Text(
                          TextHelper().formatTime(
                              date: DateTime.parse(widget.model.createdAt)),
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 11, color: Colors.white))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
                Container(
                height: 40,
                width: 40,
                child: CachedNetworkImage(
                  imageUrl: widget.model.userPhoto ?? "",
                  fadeInDuration: Duration(seconds: 2),
                  placeholder: (context, url) => CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/avatar.jpeg')),
                  imageBuilder: (context, provider) {
                    return CircleAvatar(radius: 60, backgroundImage: provider);
                  },
                ),
              ),
              Expanded(
                child: Bubble(
                  margin: BubbleEdges.all(1),
                  nip: BubbleNip.leftBottom,
                  color: Colors.white,
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Text(widget.model.message ?? "",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black)),
                      widget.model.file != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                widget.model.file,
                                height: 200,
                              ),
                            )
                          : Container(),
                      widget.model.latitude != null
                          ? Container(
                              height: 200,
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                      double.parse(widget.model.latitude),
                                      double.parse(widget.model.longitude)),
                                  zoom: 14.0,
                                ),
                                gestureRecognizers:
                                    <Factory<OneSequenceGestureRecognizer>>[
                                  new Factory<OneSequenceGestureRecognizer>(
                                    () => new EagerGestureRecognizer(),
                                  ),
                                ].toSet(),
                              ),
                            )
                          : Container(),
                      Text(
                          TextHelper().formatTime(
                              date: DateTime.parse(widget.model.createdAt)),
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 11, color: Colors.black))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
