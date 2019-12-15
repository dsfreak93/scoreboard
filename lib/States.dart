class States{
  static const String Start = "start match";
  static const String Stop = "stop match";

  static const List<String> GameStates = <String>[
    Start,
    Stop
  ];

  static String stateMessage(String state) {
    switch(state) {
      case Start:
        return "running";
      case Stop:
        return "stopped";
      default:
        return "-";
    }
  }
}