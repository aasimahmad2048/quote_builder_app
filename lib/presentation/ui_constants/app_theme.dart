import 'package:flutter/material.dart';

class AppTheme {
  static final Color _primaryColor = const Color.fromARGB(255, 179, 58, 58);
  static final Color _secondaryColor = Colors.deepPurple;

  static final ThemeData ligthTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade50,
    fontFamily: 'Poppins',
    primaryColor: _primaryColor,
    appBarTheme: const AppBarTheme(
      

iconTheme: const IconThemeData(color: Colors.white),

      
      backgroundColor: Color.fromARGB(255, 179, 58, 58),
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins',
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      hintStyle: TextStyle(color: Colors.grey.shade600),
      prefixIconColor: Colors.grey.shade500,
    ),
    cardTheme: const CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red).copyWith(
      primary: _primaryColor,
      secondary: _secondaryColor,
      error: Colors.red.shade700,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: _primaryColor,
      unselectedItemColor: Colors.grey.shade600,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      type: BottomNavigationBarType.fixed,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _primaryColor,
      foregroundColor: Colors.white,
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: _primaryColor,
      unselectedLabelColor: Colors.grey.shade600,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: _primaryColor.withOpacity(0.1),
      ),
    ),
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.white,
      titleTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      contentTextStyle: TextStyle(fontSize: 16, color: Colors.grey.shade800),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return _primaryColor;
        }
        return Colors.grey;
      }),
      checkColor: MaterialStateProperty.all(Colors.white),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return _primaryColor;
        }
        return Colors.grey;
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return _primaryColor;
        }
        return Colors.grey;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return _primaryColor.withOpacity(0.5);
        }
        return Colors.grey.withOpacity(0.5);
      }),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: _primaryColor,
      inactiveTrackColor: _primaryColor.withOpacity(0.3),
      thumbColor: _primaryColor,
      overlayColor: _primaryColor.withOpacity(0.2),
      valueIndicatorColor: _primaryColor,
      valueIndicatorTextStyle: const TextStyle(color: Colors.white),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: const TextStyle(color: Colors.white),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: _primaryColor,
      contentTextStyle: const TextStyle(color: Colors.white),
      actionTextColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
    ),
    dialogBackgroundColor: Colors.white,
    indicatorColor: Colors.blue,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: _primaryColor,
      circularTrackColor: Colors.grey,
      linearTrackColor: Colors.grey,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: _primaryColor,
      selectionColor: _secondaryColor.withOpacity(0.5),
      selectionHandleColor: _primaryColor,
    ),
    listTileTheme: ListTileThemeData(
      iconColor: _primaryColor,
      textColor: Colors.black87,
      subtitleTextStyle: TextStyle(color: Colors.grey),
    ),
    iconTheme: IconThemeData(color: _primaryColor, size: 24),
    dividerTheme: const DividerThemeData(
      color: Colors.grey,
      thickness: 1,
      indent: 16,
      endIndent: 16,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: _primaryColor,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: _primaryColor.withOpacity(0.1),
      selectedColor: _primaryColor,
      labelStyle: TextStyle(color: _primaryColor),
      secondaryLabelStyle: const TextStyle(color: Colors.white),
      brightness: Brightness.light,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),

    badgeTheme: const BadgeThemeData(
      backgroundColor: Colors.red,
      textColor: Colors.white,
      textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      iconColor: Color.fromARGB(255, 179, 58, 58),
      collapsedIconColor: Colors.grey,
      textColor: Color.fromARGB(255, 179, 58, 58),
      collapsedTextColor: Colors.black87,
      backgroundColor: Colors.white,
      collapsedBackgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    menuButtonTheme: const MenuButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(Colors.blue),
        overlayColor: MaterialStatePropertyAll(Color(0x1f000000)),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 8,
      textStyle: const TextStyle(color: Colors.black87, fontSize: 16),
    ),
  );
}
