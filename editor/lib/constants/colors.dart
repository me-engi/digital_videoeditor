// app_colors.dart
import 'package:flutter/material.dart';

class ConstColors {
  static const Color loginblue = Color(0xFF167DB7);
  static const Color loginlightblack = Color(0xFF262626);
  static const Color loginlightblue = Color(0xFFEDEDED);
  static const Color loginlightgun = Color(0xFF2D3142);
  static const Color loginlightgreen = Color(0xFF595D61);
  static const Color loginextralightblue = Color(0xFFC5C5C5);
  static const Color loginextralightgrey = Color(0xFFFBE4E1);
  static const Color backgroundColor = Color(0xFF262626);
  static const Color buttonColor = Color(0xFF167DB7);
  static const Color extralightmetal = Color(0xFF0FBFF);
  static const Color lightBlack = Color(0xFF262626);
  static const Color white = Color(0xFFFFFFFF);
  static const Color red = Color.fromARGB(255, 255, 0, 0);
  static const Color shadowColor = Color.fromARGB(255, 196, 196, 196);
  static const Color countColor = Color(0xFF800080);
  static const Color black = Colors.black;
}

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF6F47EB), // Purple
  onPrimary: Color(0xFFEEE9FD), // Light purple
  primaryContainer: Color.fromARGB(255, 224, 224, 224),
  onPrimaryContainer: Color.fromARGB(255, 245, 245, 245),
  secondary: Color(0xFFEDEDED), // Grey
  onSecondary: Color(0xFFF9F9F9), // Light grey
  secondaryContainer: Color(0xFF595D61), // Dark grey
  onSecondaryContainer: Color(0xFFC5C5C5), // Text color
  tertiary: Colors.black, // Black
  scrim: Color(0xFFF5F8FA),
  error: Color.fromARGB(255, 255, 0, 0), // Red
  onError: Color(0xFFEEE9FD), // Light purple
  tertiaryContainer: Color(0xFFEEE9FD), // Light purple
  background: Colors.white, // Background color
  onBackground: Color(0xFF1C1B1F),
  surface: Color(0xFFF9F9F9), // Light grey
  onSurface: Color(0xFF1C1B1F),
  shadow: Color.fromARGB(255, 196, 196, 196), // Shadow color
  surfaceTint: Colors.white, // White
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF6F47EB), // Purple
  onPrimary: Color(0xFFEEE9FD), // Light purple
  primaryContainer: Color(0xFF222223),
  onPrimaryContainer: Color.fromARGB(255, 245, 245, 245),
  secondary: Colors.white, // Dark gray
  onSecondary: Colors.white, // Light gray
  secondaryContainer: Colors.white, // Darker background for containers
  onSecondaryContainer: Colors.white, // Text color on dark container background
  tertiary: Color(0xFFF9F9F9),
  tertiaryContainer: Color.fromARGB(255, 64, 0, 255), // Light purple
  scrim: Colors.white,
  error: Color.fromARGB(255, 255, 0, 0), // Red
  onError: Colors.black54, // White text on red background
  background: Color(0xFF1e1e1e), // Dark background
  onBackground: Color(0xFFEEEEEE), // Light color for text on dark background
  surface: Color(0xFF333639), // Dark surface color
  onSurface: Color.fromARGB(255, 201, 8, 8), // Light color for text on dark surface
  shadow: Color.fromARGB(255, 100, 100, 100), // Adjusted shadow color
  surfaceTint: Colors.black, // Black surface tint
);

const defaultPadding = 16.0;
const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);
