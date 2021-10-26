import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nlw_project/models/user_model.dart';
import 'package:nlw_project/modules/boletoController/boletoController.dart';
import 'package:nlw_project/modules/extract/extract_page.dart';
import 'package:nlw_project/modules/home/home_controller.dart';
import 'package:nlw_project/modules/meus_boletos/meus_boletos_page.dart';
import 'package:nlw_project/themes/app_colors.dart';
import 'package:nlw_project/themes/app_text_style.dart';
import 'package:nlw_project/widgets/bottom_sheet/bottom_sheet_widget.dart';

class Home extends StatefulWidget {
  final UserModel user;
  const Home({Key? key, required this.user})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homeController = HomeController();
  final boletoController = BoletoController();
  late List pages;
  final bottomSheet = MyBottomSheet();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pages = [
      MeusBoletosPage(
        user: widget.user,
      ),
      ExtractPage(
        user: widget.user,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Container(
            alignment: Alignment.bottomCenter,
            color: AppColors.primary,
            child: ListTile(
              title: Text.rich(
                TextSpan(
                    text: "Olá, ",
                    style: TextStyles.titleRegular,
                    children: [
                      TextSpan(
                          text: "${widget.user.name}",
                          style: TextStyles.titleBoldBackground)
                    ]),
              ),
              subtitle: Text(
                "Mantenha suas contas em dia",
                style: TextStyles.captionBoldShape,
              ),
              trailing: InkWell(
                child: Container(
                  height: 54,
                  width: 54,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(widget.user.photoURL!),
                    ),
                  ),
                ),
                onTap: () {
                  bottomSheet.menuProfile(context, widget.user);
                },
              ),
            ),
          ),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height -
                80 -
                MediaQuery.of(context).padding.top,
            child: SingleChildScrollView(
              child: pages[homeController.currentPage],
            ),
          ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _currentIndex = index;
            switch (_currentIndex) {
              case 0:
                homeController.setPage(0);
                break;
              case 2:
                homeController.setPage(1);
                break;
              default:
            }
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              label: "Meus boletos",
              icon: Icon(
                Icons.home,
              ),
            ),
            BottomNavigationBarItem(
              label: "Adicionar boleto",
              icon: GestureDetector(
                onTap: () {
                  bottomSheet.addBoletoOptions(context);
                },
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
                    Icons.add_box_outlined,
                    color: AppColors.background,
                  ),
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "Meus extratos",
              icon: Icon(
                Icons.description_outlined,
              ),
            ),
          ],
        ));
  }
}
