import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart';

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({Key? key}) : super(key: key);

  @override
  _MagicBallScreenState createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen> {
  ///список возможных ответов шара
  final List<String> _answers = [
    'Да',
    'Нет',
    'Возможно',
    'Спросите позже',
    'Лучше не говорить',
  ];

  final Random _random = Random();
  String _currentAnswer = ''; /// переменная для текущего ответа
  bool _isTextVisible = true; /// флаг для видимости текста на шаре

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 15, 11, 42),
              Color.fromARGB(255, 8, 7, 25),
              Color.fromARGB(255, 2, 1, 6)
            ],
          ),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  _showRandomAnswer();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/magic_ball.png',
                      fit: BoxFit.fill,
                    ),
                    ///анимация при выводе или скрытии ответа
                    AnimatedOpacity(
                      opacity: _isTextVisible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        _currentAnswer,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          ///цветная тень под шаром
          ClipOval(
              child: Container(
            height: 60,
            width: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color.fromARGB(90, 46, 110, 202),
                  Colors.black.withOpacity(0.0),
                ],
              ),
            ),
          )),
          Container(
              margin: const EdgeInsets.only(top: 40),
              child: const Text(
                'Нажмите на шар',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white30,
                  decoration: TextDecoration.none,
                ),
              ))
        ]));
  }

  ///функция, которая выводит ответ
  void _showRandomAnswer() {
    /// если текст уже скрыт, не обрабатываем повторное нажатие
    if (!_isTextVisible) {
      return;
    }

    String randomAnswer = _answers[_random.nextInt(_answers.length)];

    setState(() {
      _isTextVisible = false; /// скрываем текст перед появлением нового ответа
    });

    /// задержка перед появлением нового текста
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _currentAnswer = randomAnswer; /// обновляем текст ответа
        _isTextVisible = true; /// показываем текст снова после задержки
      });
    });
  }
}
