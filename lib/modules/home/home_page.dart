import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nlw_project/models/user_model.dart';
import 'package:nlw_project/modules/extract/extract_page.dart';
import 'package:nlw_project/modules/home/home_controller.dart';
import 'package:nlw_project/modules/meus_boletos/meus_boletos_page.dart';
import 'package:nlw_project/themes/app_colors.dart';
import 'package:nlw_project/themes/app_text_style.dart';
import 'package:nlw_project/widgets/bottom_sheet/bottom_sheet_widget.dart';

class Home extends StatefulWidget {
  final UserModel user;
  const Home({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = HomeController();
  final List pages = [MeusBoletosPage(), ExtractPage()];
  final GlobalKey stackKey = GlobalKey();
  final bottomSheet = MyBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(152),
        child: Container(
          height: 152,
          color: AppColors.primary,
          child: Center(
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
                  height: 48,
                  width: 48,
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
      ),
      body: Stack(
        key: stackKey,
        children: [
          Container(
            color: Colors.grey[200],
            child: pages[controller.currentPage],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: AppColors.background,
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () async {
                      controller.setPage(0);
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.home,
                      color: controller.currentPage == 0
                          ? AppColors.primary
                          : AppColors.body,
                    ),
                  ),
                  GestureDetector(
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
                  IconButton(
                    onPressed: () {
                      controller.setPage(1);
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.description_outlined,
                      color: controller.currentPage == 1
                          ? AppColors.primary
                          : AppColors.body,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
