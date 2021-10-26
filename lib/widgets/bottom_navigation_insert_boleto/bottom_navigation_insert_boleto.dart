import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nlw_project/themes/app_colors.dart';

class BottomNavagationIsertBoleto extends StatelessWidget {
  final VoidCallback cadastroOnPressed;
  const BottomNavagationIsertBoleto({
    Key? key,
    required this.cadastroOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            height: 1,
            thickness: 2,
          ),
          Container(
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            height: 56,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 56,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: Text("Cancelar",
                          style: Theme.of(context).textTheme.button),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                VerticalDivider(
                  thickness: 2,
                  width: 2,
                ),
                Expanded(
                  child: Container(
                    height: 56,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      child: Text(
                        "Cadastrar",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primary),
                      ),
                      onPressed: cadastroOnPressed,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
