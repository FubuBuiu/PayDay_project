class MyDate {
  bool dateValidation(String date) {
    if (date.length == 10) {
      var day = date.substring(0, 2);
      var month = date.substring(3, 5);
      var year = date.substring(6);
      var today = DateTime.now();

      return (int.parse(day) >= 1 || int.parse(day) <= 31) &&
          (int.parse(month) >= 1 || int.parse(month) <= 12) &&
          (int.parse(year) >= today.year);
    }
    return false;
  }
}
