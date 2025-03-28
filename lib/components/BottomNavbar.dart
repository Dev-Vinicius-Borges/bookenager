import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String rota = ModalRoute.of(context)?.settings.name ?? '';
    return Align(
      alignment: AlignmentDirectional(0, 1),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 100,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 38, 45, 52),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: IconButton(
                    onPressed: () => {
                      Navigator.pushNamed(context, '/home')
                    },
                    icon: Icon(Icons.home, size: 24, color: Colors.white),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        rota == '/home'
                            ? Color.fromARGB(255, 75, 57, 239)
                            : Color.fromARGB(255, 29, 36, 40),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: IconButton(
                    onPressed: () => {
                      Navigator.pushNamed(context, '/conta')
                    },
                    icon: Icon(Icons.person, size: 24, color: Colors.white),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        rota == '/conta'
                            ? Color.fromARGB(255, 75, 57, 239)
                            : Color.fromARGB(255, 29, 36, 40),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
