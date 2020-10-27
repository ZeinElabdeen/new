import 'package:bloc/bloc.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_state.dart';
import 'package:haat/src/Screens/HomePages/Apis/Helpers/shared_helper.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/AppModels/data_model_shared.dart';

class SharedBloc extends Bloc<AppEvent, AppState> {
  final _shared = SharedHelper();
  DataModelShared _data;

  DataModelShared get data => _data;

  @override
  AppState get initialState => Start();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    yield Loading();
    if (event is Click) {
      String _name = await _shared.getString('name');
      String _email = await _shared.getString('email');
      String _img = await _shared.getString('img');
      String _phone = await _shared.getString('phone');
      int _id = await _shared.getInteger('id');

      _data = DataModelShared(
          name: _name, email: _email, img: _img, phone: _phone, id: _id);
      yield Done(
        model: DataModelShared(
          img: _img,
          id: _id,
          phone: _phone,
          name: _name,
          email: _email,
        ),
      );
    }
  }
}

final sharedBloc = SharedBloc();
