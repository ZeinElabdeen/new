import 'dart:async';

class Validator {
  var emailValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@')) {
      sink.add(email);
    } else {
      sink.addError('ادخل البريد الإكتروني بشكل صحيح');
    }
  });
  var nameValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 2) {
      sink.add(name);
    } else {
      sink.addError('ادخل الاسم بشكل صحيح');
    }
  });

  var number =
      StreamTransformer<String, String>.fromHandlers(handleData: (num, sink) {
    if (num.length > 9) {
      sink.add(num);
    } else {
      sink.addError('يجب ان يكون رقم الجوال من 10 خانات');
    }
  });

  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 7) {
      sink.add(password);
    } else {
      sink.addError('يجب ان لا تقل كلمة المرور عن 8 خانات');
    }
  });

  var confirmPassWordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 7) {
      sink.add(password);
    } else {
      sink.addError('تأكيد كلمة المرور خاطئ');
    }
  });
}
