import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nlw_project/models/boleto_model.dart';
import 'package:nlw_project/models/user_model.dart';
import 'package:nlw_project/themes/app_colors.dart';
import 'package:nlw_project/themes/app_text_style.dart';
import 'package:nlw_project/widgets/banks_list/bank_list_widget.dart';
import 'package:nlw_project/widgets/boleto_info/boleto_info_widget.dart';
import 'package:nlw_project/widgets/boleto_tile/boleto_tile_widget.dart';

class MeusBoletosPage extends StatefulWidget {
  final UserModel user;
  const MeusBoletosPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _MeusBoletosPageState createState() => _MeusBoletosPageState();
}

class _MeusBoletosPageState extends State<MeusBoletosPage> {
  final usersDB = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: usersDB
            .doc(widget.user.id)
            .collection("bank_statement")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 175,
                  child: Stack(
                    children: [
                      Container(
                        color: AppColors.primary,
                        height: 140,
                        width: double.maxFinite,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: BankListWidget(),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: BoletoInfoWidget(size: snapshot.data!.size),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
                  child: Text(
                    "Meus boletos",
                    style: TextStyles.titleBoldHeading,
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
                    final boleto = BoletoModel(
                        name: document['nome'],
                        barcode: document['codigo'],
                        dueDate: document['vencimento'],
                        value: document['valor']);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: BoletoTileWidget(
                        data: boleto,
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
