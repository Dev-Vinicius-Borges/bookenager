import 'package:bookio/components/BottomNavbar.dart';
import 'package:bookio/components/CriarLivro.dart';
import 'package:flutter/material.dart';

class BooksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromARGB(255, 20, 24, 27),
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional(0, -1),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.width * 0.763,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Meus livros",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: Builder(
                            builder: (context) {
                              return FilledButton.icon(
                                onPressed: () {
                                  showBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Criarlivro();
                                    },
                                  );
                                },
                                label: const Text(
                                  "Novo",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.plus_one,
                                  color: Colors.white,
                                ),
                                iconAlignment: IconAlignment.end,
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll<Color>(
                                        Color.fromARGB(255, 85, 103, 253),
                                      ),
                                  shape: WidgetStatePropertyAll<
                                    RoundedRectangleBorder
                                  >(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            BottomNavBar(),
          ],
        ),
      ),
    );
  }
}
