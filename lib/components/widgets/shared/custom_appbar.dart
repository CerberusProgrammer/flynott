import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  final String date;
  final IconData icon;

  const CustomAppbar({
    super.key,
    required this.title,
    required this.date,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 74,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(23, 16, 23, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black.withOpacity(.5),
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              const Spacer(),
              SizedBox(
                width: 50,
                height: 50,
                child: Card(
                  elevation: 0,
                  color: const Color(0xFFD9D9D9).withOpacity(0.5),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(10),
                    child: Icon(
                      icon,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
