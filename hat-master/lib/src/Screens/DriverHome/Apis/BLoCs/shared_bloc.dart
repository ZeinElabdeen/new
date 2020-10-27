import 'package:bloc/bloc.dart';
import 'package:haat/src/Screens/DriverHome/Apis/App/app_event.dart';
import 'package:haat/src/Screens/DriverHome/Apis/App/app_state.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Helpers/shared_helper.dart';
import 'package:haat/src/Screens/DriverHome/Apis/Models/AppModels/data_model_shared.dart';

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
      int _id = await _shared.getInteger('id');
      String _email = await _shared.getString('email');
      String _img = await _shared.getString('img');
      String _phone = await _shared.getString('phone');
      String _city = await _shared.getString('city');
      String _car = await _shared.getString('car');
      String _nat = await _shared.getString('nat');
      String _identity = await _shared.getString('iden');
      String _idNum = await _shared.getString('idNum');
      String _birth = await _shared.getString('birth');
      String _jop = await _shared.getString('jop');
      String _region = await _shared.getString('region');

      _data = DataModelShared(
          birth: _birth,
          car: _car,
          city: _city,
          nationality: _nat,
          region: _region,
          identity: _identity,
          idNumber: _idNum,
          jop: _jop,
          name: _name,
          email: _email,
          img: _img,
          phone: _phone,
          id: _id);
      yield Done(
        model: DataModelShared(
          img: _img,
          jop: _jop,
          idNumber: _idNum,
          id: _id,
          region: _region,
          birth: _birth,
          car: _car,
          city: _city,
          identity: _identity,
          nationality: _nat,
          phone: _phone,
          name: _name,
          email: _email,
        ),
      );
    }
  }
}

final sharedBloc = SharedBloc();
