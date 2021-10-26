import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nlw_project/themes/app_colors.dart';

class AppTheme {
  static ThemeData myThemeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: AppColors.primary,
      backgroundColor: isDarkTheme ? Colors.grey[900] : AppColors.background,

      highlightColor: Colors.transparent,

      splashColor: Colors.transparent,

      scaffoldBackgroundColor:
          isDarkTheme ? Colors.grey[900] : AppColors.background2,

      dividerColor: isDarkTheme ? AppColors.background : AppColors.stroke,

      iconTheme: IconThemeData(color: AppColors.primary),

      brightness: Brightness.dark,
      cardColor: AppColors.primary,

      inputDecorationTheme: InputDecorationTheme(
        labelStyle: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: isDarkTheme ? AppColors.primary : AppColors.input,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              side: BorderSide(
                  color: isDarkTheme ? AppColors.primary : AppColors.stroke),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          foregroundColor: MaterialStateColor.resolveWith(
            (states) => isDarkTheme ? AppColors.primary : Color(0xFF666666),
          ),
        ),
      ),

      textTheme: TextTheme(
        subtitle1:
            TextStyle(color: isDarkTheme ? AppColors.primary : AppColors.input),
        button: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: isDarkTheme ? AppColors.background : AppColors.grey,
        ),
        bodyText2: TextStyle(
            color: isDarkTheme ? AppColors.background : AppColors.grey),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.red, splashColor: Colors.green),

      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor:
              isDarkTheme ? Colors.grey[900] : AppColors.background),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDarkTheme ? Colors.grey[850] : AppColors.background,
        enableFeedback: false,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        selectedItemColor: AppColors.primary,
        unselectedItemColor:
            isDarkTheme ? AppColors.background : AppColors.body,
        type: BottomNavigationBarType.fixed,
      ),

      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
            color: isDarkTheme ? AppColors.background : AppColors.input),
      ),
    );
  }
}
