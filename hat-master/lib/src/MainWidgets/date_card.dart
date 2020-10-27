import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateCard extends StatefulWidget {
  final ValueChanged<String> onDate;
  final String start;

  const DateCard({Key key, this.onDate, this.start}) : super(key: key);

  @override
  _DateCardState createState() => _DateCardState();
}

class _DateCardState extends State<DateCard> {
  String _date = new DateFormat("yyyy-MM-dd").format(DateTime.now());

  _showDialogDate() async {
    final DateTime _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2030),
    );
    if (_picked != null) {
      setState(() {
        _date = new DateFormat("yyyy-MM-dd").format(_picked);
        print('>>> ' + _date);
      });
      widget.onDate(_date);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.start != null){
      setState(() {
        _date = widget.start;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, right: 20, left: 20),
      child: InkWell(
        onTap: () => _showDialogDate(),
        child: Card(
          elevation: 2,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(_date,
                    style: TextStyle(color: Colors.black, fontSize: 12)),
                Row(
                  children: <Widget>[
                    Text('تاريخ الميلاد',
                        style: TextStyle(color: Colors.black, fontSize: 14)),
                    SizedBox(width: 10),
                    Icon(Icons.calendar_today, color: Colors.black)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
