import 'package:encode_app/components/bottom_bar.dart';
import 'package:flutter/material.dart';

class PromoCodeScreen extends StatefulWidget {
  const PromoCodeScreen({super.key});

  @override
  State<PromoCodeScreen> createState() => _PromoCodeScreenState();
}

class _PromoCodeScreenState extends State<PromoCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Обратно'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
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