import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:adhara_socket_io/manager.dart';
import 'package:adhara_socket_io/options.dart';
import 'package:adhara_socket_io/socket.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:haat/src/Screens/DriverHome/Apis/BLoCs/shared_bloc.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Helpers/text_helper.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Models/AppModels/chat_msg_model.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Models/AppModels/msg_model.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Models/photo_model.dart';
import 'package:rxdart/rxdart.dart';

import 'package:haat/src/Screens/DriverHome/Apis/App/app_event.dart';
import 'package:haat/src/Screens/DriverHome/Apis/App/app_state.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Repository/api_provider.dart';

class ChatBloc extends Bloc<AppEvent, AppState> {
  final _api = ApiProvider();
  final _msg = BehaviorSubject<String>();
  final _chatID = BehaviorSubject<int>();
  final _secondUserID = BehaviorSubject<int>();
  final _photo = BehaviorSubject<File>();
  final _photoLink = BehaviorSubject<String>();
  final _lat = BehaviorSubject<String>();
  final _long = BehaviorSubject<String>();
  final _messagesController = PublishSubject<MsgModel>();
  final _key = BehaviorSubject<GlobalKey<ScaffoldState>>();
  SocketIO _socket;
  SocketIOManager _manager = SocketIOManager();
  String _ring;
  AudioPlayer audioPlayer = AudioPlayer();

  Function(String) get updateMsg => _msg.sink.add;

  Function(String) get updatePhotoLink => _photoLink.sink.add;

  Function(String) get updateLat => _lat.sink.add;

  Function(String) get updateLong => _long.sink.add;

  Function(int) get updateChatID => _chatID.sink.add;

  Function(int) get updateSecondUserID => _secondUserID.sink.add;

  Function(File) get updatePhoto => _photo.sink.add;

  Function(MsgModel) get addMessage => _messagesController.sink.add;

  Stream<MsgModel> get messages =>
      _messagesController.stream.asBroadcastStream();

  Function(GlobalKey<ScaffoldState>) get updateKey => _key.sink.add;

  dispose() {
    _key.close();
    _msg.close();
    _photoLink.close();
    _lat.close();
    _long.close();
    _chatID.close();
    _secondUserID.close();
    _msg.close();
    _photo.close();
    _messagesController.close();
    _messagesController.close();
  }

  clear() {
    _photo.value = null;
    _chatID.value = null;
    _photoLink.value = null;
    _lat.value = null;
    _long.value = null;
    _msg.value = null;
    _manager.clearInstance(_socket);
  }

  clearMsg() {
    _photo.value = null;
    _photoLink.value = null;
    _lat.value = null;
    _long.value = null;
    _msg.value = null;
  }

  @override
  AppState get initialState => Start();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Restart) {
      yield Start();
    }
    if (event is UploadPhoto) {
      if (_photo.value != null) {
        PhotoModel _res =
        await _api.uploadPhoto(photo: _photo.value).catchError((e) {
          _key.value.currentState
              .showSnackBar(SnackBar(content: Text('تحقق من الإتصال')));
        });
        if (_res.code == 200) {
          updatePhotoLink(_res.data[0].value);
        }
      }
    }
    if (event is Init) {
      PhotoModel _voice = await _api.getVoiceRing().catchError((e) {
        _key.value.currentState
            .showSnackBar(SnackBar(content: Text('تحقق من الإتصال')));
      });
      if (_voice.code == 200) {
        _ring = _voice.data[0].value;
      }
      sharedBloc.add(Click());
      var _old = await _api.getMessages(chatID: _chatID.value);
      if (_old.code == 200) {
        for (int i = 0; i < _old.data.length; i++) {
          if (_old.data[i].message != null ||
              _old.data[i].file != null ||
              _old.data[i].latitude != null ||
              _old.data[i].longitude != null) {
            addMessage(_old.data[i]);
          }
        }
      }
      print('>>> Start init');
      _socket = await _manager.createInstance(
        SocketOptions("http://dashboard.haat-app.com:3663",
            query: {
              "order_id": "${_chatID.value}",
            },
            enableLogging: true,
            transports: [
              Transports.WEB_SOCKET,
              Transports.POLLING,
            ] //Enable required transport
        ),
      );
      _socket.onConnect((connection) {
        print('<<< Socket connected >>>');
        _socket.on('chat message-${_chatID.value}', (data) async {
          print('<<< Receive Msg >>>');
          MsgModel _msg = new MsgModel(
            message: data["data"]["message"],
            id: data["data"]["user_id"],
            latitude: data["data"]["latitude"],
            longitude: data["data"]["longitude"],
            file: data["data"]["file"],
            createdAt: data["data"]["created_at"],
            name: data["data"]["user_name"],
            userPhoto: data["data"]["user_photo"],
            voice: data["data"]["voice"],
          );
          await audioPlayer.play(_ring);
          addMessage(_msg);
        });
      });
      _socket.connect();
    }
    if (event is SendMsg) {
      ChatMsgModel _messageModel = new ChatMsgModel(
          channel: "chat message",
          data: new MsgModel(
            message: _msg.value,
            userId: sharedBloc.data.id,
            id: _chatID.value,
            createdAt: TextHelper().formatDateTime(date: DateTime.now()),
            secondUserId: _secondUserID.value,
            latitude: _lat.value,
            longitude: _long.value,
            file: _photoLink.value,
            name: sharedBloc.data.name,
            userPhoto: sharedBloc.data.img,
          ));
      MsgModel _newMsg = new MsgModel(
        message: _msg.value,
        userId: sharedBloc.data.id,
        id: _chatID.value,
        secondUserId: _secondUserID.value,
        latitude: _lat.value,
        createdAt: TextHelper().formatDateTime(date: DateTime.now()),
        longitude: _long.value,
        file: _photoLink.value,
        name: sharedBloc.data.name,
        userPhoto: sharedBloc.data.img,
      );
      clearMsg();
      var _jsonMsg = json.encode(_messageModel);
      _socket.emit("chat message-${_chatID.value}", [_jsonMsg]);
      addMessage(_newMsg);
    }
  }
}

final chatBloc = ChatBloc();
