
import 'package:haat/src/Screens/HomePages/Apis/Models/AppModels/base_model.dart';

abstract class AppState {}

class Done extends AppState {
  BaseModel model;

  Done({this.model});
}

class Error extends AppState {
  String msg;

  Error({this.msg});
}

class Start extends AppState {}

class Loading extends AppState {}

class PhoneError extends AppState {}

class PhoneOk extends AppState {}

class PhoneFailed extends AppState {}

class CodeOk extends AppState {}

class CodeFailed extends AppState {}

class CodeResent extends AppState {}

class NameError extends AppState {}

class PasswordError extends AppState {}

class CodeSentForForget extends AppState {}

class PasswordResetDone extends AppState {}

class PasswordResetError extends AppState {}

class CodeSentForChange extends AppState {}

class PhoneNotStored extends AppState {}

class CodeCorrectForChange extends AppState {}

class CodeErrorForChange extends AppState {}

class PlaceError extends AppState {}

class OrderDetailsError extends AppState {}

class Empty extends AppState {}

class Accepted extends AppState {
  int orderID;

  Accepted({this.orderID});
}

class OrderCancelled extends AppState {}

class OrderFinished extends AppState {}

class NotEqual extends AppState {}

class TitleError extends AppState {}

class ContentError extends AppState {}
