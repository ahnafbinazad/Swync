String formatTotalWorkoutTime(int totalMinutes) {
  int days = totalMinutes ~/ (60 * 24);
  int hours = (totalMinutes ~/ 60) % 24;
  int minutes = totalMinutes % 60;
  
  String formattedTime = '';
  if (days > 0) {
    formattedTime += '$days' 'd, ';
  }
  if (hours > 0) {
    formattedTime += '$hours' 'h, ';
  }
  formattedTime += '$minutes' 'm';

  return formattedTime;
}