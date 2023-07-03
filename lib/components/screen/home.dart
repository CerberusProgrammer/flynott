import 'package:flutter/material.dart';
import 'package:flynott/components/widgets/shared/custom_appbar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Column(
        children: [
          CustomAppbar(
            title: 'Greatings Title',
            date: '20 May 2023',
            icon: Icons.settings,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(23),
              child: Wrap(
                children: [
                  SizedBox(
                    width: 140,
                    child: Card(
                      elevation: 0,
                      color: Colors.amber,
                      child: Text(
                        'skdsdalksdlassdlkdslkdlskdlskdlskddkladladlalkdkladlka',
                        style: TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Card(
                      elevation: 0,
                      color: Colors.amber,
                      child: Text(
                        'skdsdalksdlassdlkdslkdlskdlskdlskddkladladlalkdkladlka',
                        style: TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
