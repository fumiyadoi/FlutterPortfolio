generateId() {
  final _now = DateTime.now();
  final _docId = _now.year.toString() +
      _now.month.toString() +
      _now.day.toString() +
      _now.hour.toString() +
      _now.minute.toString() +
      _now.second.toString() +
      _now.millisecond.toString() +
      _now.microsecond.toString();
  return _docId;
}
