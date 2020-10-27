
// import 'package:dio/dio.dart';
// import 'package:haat/src/BloCModels/AppModels/base_model.dart';
// import 'package:haat/src/Helpers/shared_helper.dart';

// class NetworkUtil {
//   static NetworkUtil _instance = new NetworkUtil.internal();

//   NetworkUtil.internal();

//   factory NetworkUtil() => _instance;

//   Dio _dio = Dio();

//   SharedHelper _sharedHelper = SharedHelper();

//   Future<dynamic> get(String url,
//       {bool withToken = false, BaseModel model}) async {
//     Response _response;
//     Map<String, String> _headers = {};
//     String _token;
//     try {
//       if (withToken) {
//         _token = await _sharedHelper.getString('token');
//         _headers.addAll({
//           'Authorization': 'Bearer $_token',
//           "Content-Type": "multipart/form-data"
//         });
//       }
//       _dio.options.baseUrl = "http://cp.haatapplication.com/api/v1/";
//       _response = await _dio.get(url, options: Options(headers: _headers));
//       print("correrct request: " + _response.toString());
//     } on DioError catch (e) {
//       _response = e.response;
//       print("excption: " + e.response.toString());
//     }
//     if (model == null) {
//       return _response;
//     } else {
//       return model.fromJson(_response.data);
//     }
//   }

//   Future<dynamic> post(String url,
//       {FormData body, bool withToken = false, BaseModel model}) async {
//     Response _response;
//     Map<String, String> _headers = {};
//     String _token;
//     _dio.options.baseUrl = "http://cp.haatapplication.com/api/v1/";
//     try {
//       if (withToken) {
//         _token = await _sharedHelper.getString('token');
//         _headers.addAll({
//           'Authorization': 'Bearer $_token',
//           "Content-Type": "multipart/form-data"
//         });
//       }
//       _response =
//           await _dio.post(url, data: body, options: Options(headers: _headers));
//       print("correrct request: " + _response.toString());
//     } on DioError catch (e) {
//       _response = e.response;
//       print("excption: " + e.response.toString());
//     }
//     if (model == null) {
//       return _response;
//     } else {
//       return model.fromJson(_response.data);
//     }
//   }
// }
