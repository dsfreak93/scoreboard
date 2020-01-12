class States{
  static const String Start = "start match";
  static const String Stop = "stop match";
  static const String NewMatch = "new match";
  static const String Pause = "pause match";




  static const List<String> GameStates = <String>[
    Start,
    Pause,
    Stop,
    NewMatch
  ];

  static String stateMessage(String state) {
    switch(state) {
      case Start:
        return "running";
      case Stop:
        return "stopped";
      case NewMatch:
        return "new match";
      case Pause:
        return "match paused";
      default:
        return "-";
    }
  }
}