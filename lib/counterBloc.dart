
import 'dart:async';

class CounterBloc{

  int value = 0;
  StreamController<int> valueController = StreamController<int>();

  void dispose(){
    valueController.close();
  }

   increment(){
    print(value);
    value++;
    valueController.sink.add(value);
  }

  decrement(){
    print(value);
    value--;
    valueController.sink.add(value);
  }

  Stream<int> getStreamValue(){
    return valueController.stream;
  }


}