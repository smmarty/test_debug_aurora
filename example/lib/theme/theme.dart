// SPDX-FileCopyrightText: 2023 Open Mobile Platform LLC <community@omp.ru>
// SPDX-License-Identifier: BSD-3-Clause
import 'package:flutter/material.dart';
import 'package:flutter_example_packages/theme/colors.dart';
import 'package:flutter_example_packages/theme/radius.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData.light();

final appTheme = ThemeData(
  colorScheme: theme.colorScheme.copyWith(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
  ),

  /// [Card]
  cardTheme: CardTheme(
    clipBehavior: Clip.antiAlias,
    margin: const EdgeInsets.all(0),
    color: AppColors.primary.withOpacity(0.4),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: AppRadius.small,
    ),
  ),

  /// [TextField]
  inputDecorationTheme: theme.inputDecorationTheme.copyWith(
    contentPadding: const EdgeInsets.symmetric(
      vertical: 14,
      horizontal: 16,
    ),
    border: const OutlineInputBorder(),
  ),

  /// [ElevatedButton]
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.secondary,
      minimumSize: const Size.fromHeight(45),
    ),
  ),

  /// [OutlinedButton]
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.secondary,
      fixedSize: const Size.fromHeight(45),
      side: const BorderSide(color: AppColors.secondary),
    ),
  ),

  /// [Text]
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.roboto(
      fontSize: 44,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: GoogleFonts.roboto(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: GoogleFonts.roboto(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.roboto(
      fontSize: 20,
      height: 1.3,
    ),
    titleMedium: GoogleFonts.roboto(
      fontSize: 18,
      height: 1.3,
    ),
    titleSmall: GoogleFonts.roboto(
      fontSize: 14,
      height: 1.3,
    ),
    bodyLarge: GoogleFonts.openSans(
      fontSize: 18,
      height: 1.3,
    ),
    bodyMedium: GoogleFonts.openSans(
      fontSize: 16,
      height: 1.3,
    ),
    bodySmall: GoogleFonts.openSans(
      fontSize: 12,
      height: 1.3,
    ),
  ),
);
