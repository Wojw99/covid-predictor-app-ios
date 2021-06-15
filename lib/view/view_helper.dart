class ViewHelper {
  static String formatNumber(String number) {
    var delimiter = ' ';
    var format = '###$delimiter###$delimiter###$delimiter###$delimiter###';

    for (var i = number.length - 1; i >= 0; i--) {
      format = format.replaceFirst('#', number[i]);
    }

    format = format.replaceAll('#', '');
    format = format.split('').reversed.join();
    format = format.trim();

    return format;
  }
}
