import 'package:scoped_model/scoped_model.dart';
import 'package:grabApp/DataModels/Screens.dart';

class AppModel extends Model {
  Screen curScreen = Screen.BookScreen;
  int i = 0;

  void nextScreen() {
    i += 1;
    i = i % 4;
    curScreen = Screen.values[i];
    notifyListeners();
  }
}

class AppState {}
