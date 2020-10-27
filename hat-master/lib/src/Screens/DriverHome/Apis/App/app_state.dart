import 'package:haat/src/Screens/DriverHome/Apis/Models/AppModels/base_model.dart';

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

class Empty extends AppState {}

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

class RegionsDone extends AppState {
  BaseModel model;

  RegionsDone({this.model});
}

class CitiesDone extends AppState {
  BaseModel model;

  CitiesDone({this.model});
}

class NationalitiesDone extends AppState {
  BaseModel model;

  NationalitiesDone({this.model});
}

class CarTypesDone extends AppState {
  BaseModel model;

  CarTypesDone({this.model});
}

class IdentityDone extends AppState {
  BaseModel model;

  IdentityDone({this.model});
}

class EmailError extends AppState {}

class JopError extends AppState {}

class IdNumError extends AppState {}

class AvailableShared extends AppState {
  int ava;

  AvailableShared({this.ava});
}

class PriceError extends AppState {}

class BillError extends AppState {}

class BillImgError extends AppState {}

class BillSent extends AppState {}

class NotEqual extends AppState {}

class TitleError extends AppState {}

class ContentError extends AppState {}

class RequestSent extends AppState {}

class RequestError extends AppState {}

class OrderCancelled extends AppState {}

