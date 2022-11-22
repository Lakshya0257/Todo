import 'package:get/get.dart';

class TaskProgress extends GetxController{
  int _completed=0;
  int _incomplete = 0;
  double _percentage= 0.1;
  double _ratio= 0.1;
  int get completed=>_completed;
  double get task_ratio=>_ratio;
  String date='';
  int get incomplete=>_incomplete;
  double get percentage_task=>_percentage;


  void values(int x,int y,String datee){
    _completed=x;
    _incomplete=y;
    date=datee;
    update();
    ratio();
    percentage();
  }

  void ratio(){
    _ratio=_completed/(_completed+_incomplete);
    update();
  }

  void percentage(){
    _percentage=double.parse((_completed*100/(_completed+_incomplete)).toStringAsFixed(2));
    update();
  }
}