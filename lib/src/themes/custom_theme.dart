import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nearby_nocard/app_exports.dart';

class CustomTheme {
  static final lightTheme = FlexColorScheme.light(
          scheme: FlexScheme.material,
          fontFamily: GoogleFonts.poppins().fontFamily,
          colorScheme:
              ColorScheme.fromSeed(seedColor: FlexColor.aquaBlueDarkPrimary),
          useMaterial3: true)
      .toTheme;

  static final darkTheme = FlexColorScheme.dark(
          scheme: FlexScheme.material,
          fontFamily: GoogleFonts.poppins().fontFamily,
          useMaterial3: true)
      .toTheme;
}
