import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Warna utama halaman
  static const Color background = Color(0xFFE1EAEF);

  // Warna AppBar
  static const Color primaryLight = Color(0xFFC1DBE8);

  // Warna card resep HomeScreen
  static const Color recipeCard = Color(0xFFECE4B1);

  // Warna teks
  static const Color textPrimary = Color(0xFF43302E);
  static const Color textSecondary = Color(0xFF5D4441);

  // Warna aksen dan tombol
  static const Color accent = Color(0xFFFFF185);

  static const Color white = Color(0xFFFFFFFF);
}

class AppTextStyles {
  // Judul halaman
  static const TextStyle heading = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 25,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  // Judul resep di card
  static const TextStyle cardTitle = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  // Subjudul dan kategori
  static const TextStyle subtitle = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // Instruksi dan deskripsi resep
  static const TextStyle body = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.6,
  );

  // Teks tombol
  static const TextStyle button = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );
}