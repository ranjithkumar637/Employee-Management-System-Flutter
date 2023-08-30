import 'package:flutter/cupertino.dart';

class NavigationProvider extends ChangeNotifier {

  int currentIndex = 0;

  setCurrentIndex(int index){
    currentIndex = index;
    notifyListeners();
  }

  moveToHome(){
    currentIndex = 0;
    notifyListeners();
  }

  moveToMatches(){
    currentIndex = 3;
    notifyListeners();
  }

}