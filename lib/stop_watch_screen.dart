import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  Timer? _timer;

  int _time = 0;
  bool _isRunning = false;

  final List<String> _lapTimes = [];

  //플레이 버튼 눌렀을 때 상태가 바뀌는 함수
  void _clickButton() {
    _isRunning = !_isRunning;

    if (_isRunning) {
      _start();
    } else {
      _pause();
    }
  }

  void _start() {
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _time++;
      });
    });
  }

  void _pause() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel(); //nullable객체에서 if문으로 null체크를 하지 않는 방법
    super.dispose();
  }

  void _reset() {
    _isRunning = false;
    _timer?.cancel();
    _lapTimes.clear();
    _time = 0;
  }

  void _recordLapTime(String time) {
    _lapTimes.insert(0, '${_lapTimes.length + 1}등 $time');
  }

  @override
  Widget build(BuildContext context) {
    int sec = _time ~/ 100; //몫을 구하기
    String hundredth = '${_time % 100}'.padLeft(2, '0'); //뒤에 00도 표시하기 위해서?

    return Scaffold(
      appBar: AppBar(
        title: const Text('스톱워치'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$sec',
                style: TextStyle(fontSize: 50),
              ),
              Text(
                '$hundredth', //밀리미터가 올라갈때 01이 아니라 1이 카운트되어서 자리가 움직이는 것 같이 느낌
              ),
            ],
          ),
          SizedBox(
            width: 100,
            height: 200,
            child: ListView(
              children:
                  _lapTimes.map((time) => Center(child: Text(time))).toList(),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.orange,
                onPressed: () {
                  setState(() {
                    _reset();
                  });
                },
                child: const Icon(
                  Icons.refresh,
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _clickButton();
                  });
                },
                child: _isRunning
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_arrow),
              ),
              FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed: () {
                  setState(() {
                    _recordLapTime('$sec.$hundredth');
                  });
                },
                child: const Icon(
                  Icons.add,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
