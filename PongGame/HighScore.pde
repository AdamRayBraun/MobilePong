class HighScore {
  int score;
  String name;

  HighScore(String nameTemp, int scoreTemp){
    name = nameTemp;
    score = scoreTemp;
  }

  void update(String nameTemp, int scoreTemp){
    name = nameTemp;
    score = scoreTemp;
  }

}
