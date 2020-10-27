// import 'package:flutter/material.dart';

// class CarData extends StatefulWidget {
//   @override
//   _CarDataState createState() => _CarDataState();
// }

// class _CarDataState extends State<CarData> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             Text(
//               "بيانات سيارتي",
//               style: TextStyle(color: Colors.white),
//             ),
//           ],
//         ),
//         leading: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: 4,
//         itemBuilder: (c,index){
//         return Image.network("https://www.sentinelassam.com/wp-content/uploads/2019/01/car-driver-licence-card-vector-16395364.jpg") ;
//       }),
//     );
//   }
// }