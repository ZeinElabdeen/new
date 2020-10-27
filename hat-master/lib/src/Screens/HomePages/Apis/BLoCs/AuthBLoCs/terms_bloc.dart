import 'package:bloc/bloc.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_event.dart';
import 'package:haat/src/Screens/HomePages/Apis/App/app_state.dart';
import 'package:haat/src/Screens/HomePages/Apis/Models/terms_model.dart';
import 'package:haat/src/Screens/HomePages/Apis/Repository/api_provider.dart';

class TermsBloc extends Bloc<AppEvent, AppState> {
  final _api = ApiProvider();

  @override
  AppState get initialState => Start();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    yield Loading();
    if (event is GetTerms) {
      TermsModel _model = await _api.getTerms();
      yield Done(model: _model);
    }
    if (event is GetAbout) {
      TermsModel _model = await _api.getAbout();
      yield Done(model: _model);
    }
  }
}

final termsBloc = TermsBloc();
