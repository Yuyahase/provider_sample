import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  //発火したいイベントを持つwidgetをConsumerでwrapする
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => CountModel(),
      child: Consumer<CountModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('Flutter Demo Home Page'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                CountText()
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: model.increment,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

//ChangeNotifierを継承したモデルを作成する
class CountModel extends ChangeNotifier {
  int count = 0;
  void increment() {
    count++;
    notifyListeners();
  }
}

class CountText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      //値を更新したい箇所にProviderでwrapする
      '${Provider.of<CountModel>(context).count}',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
