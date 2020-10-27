class TextHelper {
  String formatDate({DateTime date}) {
    return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  String name({String name}){
    if (name.length < 10){
      return name;
    } else {
      return ' .. ' + name.substring(0, 10);
    }
  }

  String nameProfile({String name}){
    if (name.length < 20){
      return name;
    } else {
      return ' .. ' + name.substring(0, 20);
    }
  }
}
