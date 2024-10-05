import 'package:flutter/material.dart';
import 'package:machine_test_dfine/config/app_constants.dart';
import 'package:machine_test_dfine/core/text_styles.dart';

ThemeData darkTheme=ThemeData(
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primaryColorLight,
    hoverColor: Colors.blue,
  ),
  listTileTheme: const ListTileThemeData(
    subtitleTextStyle: AppTextStyles.labelLarge,
    tileColor: AppColors.darkTileBackground,
    titleTextStyle: AppTextStyles.headlineSmall,
  ),
  iconTheme: const IconThemeData(
    color: Colors.blue
  ),
appBarTheme: const AppBarTheme(
  iconTheme: IconThemeData(color: Colors.white),
  titleTextStyle: AppTextStyles.displaySmall,
  backgroundColor: AppColors.primaryColorDark
),
scaffoldBackgroundColor: AppColors.primaryColorDark,
textTheme: const TextTheme(
    displayLarge: AppTextStyles.displayLarge,
    displayMedium: AppTextStyles.displayMedium,
    displaySmall: AppTextStyles.displaySmall,
    headlineLarge:AppTextStyles.headlineLarge,
    headlineMedium: AppTextStyles.headlineMedium,
    headlineSmall:AppTextStyles.headlineSmall,
    titleLarge: AppTextStyles.titleLarge,
    titleMedium: AppTextStyles.titleMedium,
    titleSmall: AppTextStyles.titleSmall,
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    bodySmall: AppTextStyles.bodySmall,
    labelLarge: AppTextStyles.labelLarge,
    labelMedium: AppTextStyles.labelMedium,
    labelSmall: AppTextStyles.labelSmall
  ),
);

