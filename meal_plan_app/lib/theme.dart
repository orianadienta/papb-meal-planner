// import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';

// class AppColors {
//   // Warna utama halaman
//   static const Color background = Color(0xFFE1EAEF);

//   // Warna AppBar
//   static const Color primaryLight = Color(0xFFC1DBE8);

//   // Warna card resep HomeScreen
//   static const Color recipeCard = Color(0xFFECE4B1);

//   // Warna teks
//   static const Color textPrimary = Color(0xFF43302E);
//   static const Color textSecondary = Color(0xFF5D4441);

//   // Warna aksen dan tombol
//   static const Color accent = Color(0xFFFFF185);

//   static const Color white = Color(0xFFFFFFFF);
// }

// class AppTextStyles {
//   // Judul halaman
//   static const TextStyle heading = TextStyle(
//     fontFamily: 'Nunito',
//     fontSize: 25,
//     fontWeight: FontWeight.w800,
//     color: AppColors.textPrimary,
//   );

//   // Judul resep di card
//   static const TextStyle cardTitle = TextStyle(
//     fontFamily: 'Nunito',
//     fontSize: 16,
//     fontWeight: FontWeight.w700,
//     color: AppColors.textPrimary,
//   );

//   // Subjudul dan kategori
//   static const TextStyle subtitle = TextStyle(
//     fontFamily: 'DMSans',
//     fontSize: 15,
//     fontWeight: FontWeight.w400,
//     color: AppColors.textSecondary,
//   );

//   // Instruksi dan deskripsi resep
//   static const TextStyle body = TextStyle(
//     fontFamily: 'DMSans',
//     fontSize: 15,
//     fontWeight: FontWeight.w400,
//     color: AppColors.textPrimary,
//     height: 1.6,
//   );

//   // Teks tombol
//   static const TextStyle button = TextStyle(
//     fontFamily: 'Nunito',
//     fontSize: 14,
//     fontWeight: FontWeight.w700,
//   );
// }


import 'package:flutter/material.dart';

class AppColors {
  // 60% - Neutral / background
  static const Color background = Color(0xFFF7F4F0); // Warm Oat / Ivory
  static const Color surface = Color(0xFFFFFFFF);    // Card di atas background
  static const Color divider = Color(0xFFE6DFD6);    // Garis pemisah / border tipis

  // 30% - Primary (AppBar, card, navigasi)
  static const Color primary = Color(0xFF4A3B32);    // Deep Espresso
  static const Color onPrimary = Color(0xFFF7F4F0);  // Teks/ikon di atas primary

  // 10% - Accent (tombol, ikon aktif, timer, kategori)
  static const Color accent = Color(0xFFC86D51);     // Rust Red
  static const Color onAccent = Color(0xFFFFFFFF);   // Teks di atas tombol accent

  // Teks
  static const Color textPrimary = Color(0xFF222222);   // Soft Black
  static const Color textSecondary = Color(0xFF6B5F57); // Brown abu, kontras ~5.5:1 di ivory

  static const Color white = Color(0xFFFFFFFF);
}

class AppTextStyles {
  // Judul halaman
  static const TextStyle heading = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 25,
    fontWeight: FontWeight.w800,
    color: AppColors.primary,
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

  // Instruksi dan deskripsi resep (kontras tinggi: #222222 di #F7F4F0)
  static const TextStyle body = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.6,
  );

  // Teks tombol
  static const TextStyle button = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.onAccent,
  );

  // Label kategori / timer (accent)
  static const TextStyle accentLabel = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.accent,
  );
}