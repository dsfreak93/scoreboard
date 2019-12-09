class Scoreboard{
  var team = [0, 0];

  void resetPoints(){
    team[0]=0;
    team[1]=0;
  }

  void subtractNumbers(int teamIndex) {
    if(overzero(team[teamIndex])){
      team[teamIndex] --;
    }
  }

  void addNumbers(int teamIndex) {
    if(underNinetyNine(team[teamIndex])){
      team[teamIndex] ++;
    }
  }

  bool underNinetyNine(var team) {
    if(team<99){
      return true;
    }
    else{
      return false;
    }
  }

  bool overzero(var team) {
    if(team >0){
      return true;
    }
    else{
      return false;
    }
  }
}