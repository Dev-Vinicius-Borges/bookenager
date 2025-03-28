import 'package:bookio/Server/session/config.dart';
import 'package:bookio/components/BottomNavbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int? id_usuario =
        Provider.of<SessionManager>(context, listen: false).idUsuario;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromARGB(255, 20, 24, 27),
        child: Stack(
          children: [
            Text(id_usuario.toString(), style: TextStyle(color: Colors.white)),
            BottomNavBar(),
          ],
        ),
      ),
    );
  }
}
