import 'package:encode_app/components/bottom_bar.dart';
import 'package:flutter/material.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Обратно'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Text('В процессе разработки')
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomMainBar(),
    );
  }
}