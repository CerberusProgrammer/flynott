import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flynott/components/widgets/shared/custom_appbar.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static const appRouterName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppbar(
              title: 'Greatings Title',
              date: '20 May 2023',
              icon: Icons.settings,
            ),
            Padding(
              padding: const EdgeInsets.all(23.0),
              child: StaggeredGrid.count(
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 2,
                children: const [
                  CardCategoryNote(
                    date: '20 May 2023',
                    quantityNote: '04',
                    titleNote: 'Material Design',
                    color: Color(0xFFFFF377),
                  ),
                  CardCategoryNote(
                    date: '10 Apr 2023',
                    quantityNote: '14',
                    titleNote: 'Flutter Material Design version for more style',
                    color: Color(0xFF81FFA7),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: const Color(0xFFD9D9D9),
        splashColor: const Color.fromARGB(146, 255, 255, 255),
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}

class CardCategoryNote extends StatelessWidget {
  final String quantityNote;
  final String titleNote;
  final String date;
  final Color color;

  const CardCategoryNote({
    super.key,
    required this.quantityNote,
    required this.titleNote,
    required this.date,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        elevation: 0,
        color: color,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(13, 15, 0, 0),
                child: Text(
                  quantityNote,
                  style: GoogleFonts.josefinSans(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(.65),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(13, 33, 13, 0),
                child: Text(
                  titleNote,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(.8),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(13, 2, 13, 15),
                child: Text(
                  date,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(.4),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
