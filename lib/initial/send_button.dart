import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 遷移元
class SendButton extends StatefulWidget {
  @override
  _SendButton createState() => _SendButton();
}

class _SendButton extends State<SendButton> {
  String _result = 'まだここ';

  @override
  void initState() {
    super.initState();
    _result = "遷移先に移動";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Home Page（遷移元）'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _result,
              style: Theme.of(context).textTheme.headline5,
            ),
            ElevatedButton(
              child: Text('Go to Edit Page'),
              onPressed: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        // 引数に遷移元から遷移先へ渡す値を設定
                        EditPage(receive: 'Hello! from HomePage.'),
                  ),
                );
                print(result);
                setState(() {
                  _result = result;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _result = "遷移先に移動";
          });
        },
        tooltip: 'Increment',
        child: Icon(
          Icons.refresh,
        ),
      ),
    );
  }
}

// 遷移先
class EditPage extends StatelessWidget {
  final receive;
  const EditPage({Key? key, this.receive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // 第2引数に渡す値を設定
        Navigator.pop(context, 'Thank you! from 戻るアイコン');
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Page（遷移先）'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                receive,
                style: Theme.of(context).textTheme.headline5,
              ),
              ElevatedButton(
                child: Text('Return'),
                onPressed: () =>
                    Navigator.of(context).pop('Thank you! from 戻るボタン'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
