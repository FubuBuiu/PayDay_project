import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nlw_project/models/boleto_model.dart';
import 'package:nlw_project/models/user_model.dart';
import 'package:nlw_project/themes/app_text_style.dart';
import 'package:nlw_project/widgets/boleto_tile/boleto_extract_tile_widget.dart';

class ExtractPage extends StatefulWidget {
  final UserModel user;
  ExtractPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _ExtractPageState createState() => _ExtractPageState();
}

class _ExtractPageState extends State<ExtractPage> {
  final usersDB = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: usersDB
            .doc(widget.user.id)
            .collection("extract")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(child: Center(child: CircularProgressIndicator()));
          }
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Meus extratos",
                        style: TextStyles.titleBoldHeading,
                      ),
                      Expanded(child: SizedBox()),
                      Text(
                        "${snapshot.data!.size} pagos",
                        style: GoogleFonts.inter(
                            fontSize: 13, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                  child: Divider(thickness: 2, height: 1),
                ),
                Column(
                  children: 
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                    final extract = BoletoModel(
                        name: document['nome'],
                        barcode: document['codigo'],
                        dueDate: document['vencimento'],
                        value: document['valor']);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: BoletoExtractTileWidget(
                        data: extract,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        });
  }
}
