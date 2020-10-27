import 'package:flutter/material.dart';
import 'package:haat/src/provider/termsProvider.dart';
import 'package:provider/provider.dart';

class TermsDialog {
  show({BuildContext context}) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: SimpleDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                backgroundColor: Colors.white,
                elevation: 5,
                contentPadding: EdgeInsets.all(10),
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Icon(
                          Icons.close,
                          size: 25,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        Provider.of<TermsProvider>(context, listen: false)
                            .content,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 300),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        // ignore: missing_return
        pageBuilder: (context, animation1, animation2) {});
  }
}
