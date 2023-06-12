import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color black = Color.fromRGBO(0, 0, 0, 1);
  static const Color transparent = Colors.transparent;

  /// Die Farbspezifikation ist gemäß dem Material Design von Google definiert.
  /// Von 50 bis 900 sind diese Farben in der Reihenfolge von heller zu dunkler
  /// angeordnet und können verwendet werden, um eine einheitliche und
  /// ästhetisch ansprechende Benutzeroberfläche zu schaffen.
  ///
  /// In Material Design, die Nummer "500" in der Farbnummerierung repräsentiert
  /// das Standardniveau der Farbe. Diese Stufe steht für eine mittlere
  /// Sättigung und Helligkeit und wird in der Regel als Standardwert für die
  /// Farbe verwendet.
  ///
  /// 'fhwaveBlue500' ist Prämierfarbe der fhwave-App
  static const Color fhwaveBlue50 = Color.fromRGBO(243, 249, 255, 1);
  static const Color fhwaveBlue100 = Color.fromRGBO(219, 235, 255, 1);
  static const Color fhwaveBlue200 = Color.fromRGBO(202, 226, 255, 1);
  static const Color fhwaveBlue300 = Color.fromRGBO(177, 212, 255, 1);
  static const Color fhwaveBlue400 = Color.fromRGBO(162, 204, 255, 1);
  static const Color fhwaveBlue500 = Color.fromRGBO(139, 191, 255, 1);
  static const Color fhwaveBlue600 = Color.fromRGBO(126, 174, 232, 1);
  static const Color fhwaveBlue700 = Color.fromRGBO(99, 136, 181, 1);
  static const Color fhwaveBlue800 = Color.fromRGBO(76, 105, 140, 1);
  static const Color fhwaveBlue900 = Color.fromRGBO(58, 80, 107, 1);

  /// 'fhwavePurple500' ist Sekundärfarbe der fhwave-App
  static const Color fhwavePurple50 = Color.fromRGBO(250, 245, 255, 1);
  static const Color fhwavePurple100 = Color.fromRGBO(239, 224, 254, 1);
  static const Color fhwavePurple200 = Color.fromRGBO(231, 209, 253, 1);
  static const Color fhwavePurple300 = Color.fromRGBO(219, 188, 252, 1);
  static const Color fhwavePurple400 = Color.fromRGBO(213, 175, 252, 1);
  static const Color fhwavePurple500 = Color.fromRGBO(202, 155, 251, 1);
  static const Color fhwavePurple600 = Color.fromRGBO(184, 141, 228, 1);
  static const Color fhwavePurple700 = Color.fromRGBO(143, 110, 178, 1);
  static const Color fhwavePurple800 = Color.fromRGBO(111, 85, 138, 1);
  static const Color fhwavePurple900 = Color.fromRGBO(85, 65, 105, 1);

  /// 'fhwaveGreen500' ist Sekundärfarbe der fhwave-App
  static const Color fhwaveGreen50 = Color.fromRGBO(239, 249, 245, 1);
  static const Color fhwaveGreen100 = Color.fromRGBO(204, 237, 223, 1);
  static const Color fhwaveGreen200 = Color.fromRGBO(180, 228, 208, 1);
  static const Color fhwaveGreen300 = Color.fromRGBO(145, 216, 187, 1);
  static const Color fhwaveGreen400 = Color.fromRGBO(124, 209, 173, 1);
  static const Color fhwaveGreen500 = Color.fromRGBO(91, 197, 153, 1);
  static const Color fhwaveGreen600 = Color.fromRGBO(83, 179, 139, 1);
  static const Color fhwaveGreen700 = Color.fromRGBO(65, 140, 109, 1);
  static const Color fhwaveGreen800 = Color.fromRGBO(50, 108, 84, 1);
  static const Color fhwaveGreen900 = Color.fromRGBO(38, 83, 64, 1);

  /// 'fhwaveYellow500' ist Sekundärfarbe der fhwave-App
  static const Color fhwaveYellow50 = Color.fromRGBO(254, 255, 244, 1);
  static const Color fhwaveYellow100 = Color.fromRGBO(253, 254, 221, 1);
  static const Color fhwaveYellow200 = Color.fromRGBO(252, 254, 204, 1);
  static const Color fhwaveYellow300 = Color.fromRGBO(251, 254, 181, 1);
  static const Color fhwaveYellow400 = Color.fromRGBO(250, 253, 167, 1);
  static const Color fhwaveYellow500 = Color.fromRGBO(249, 253, 145, 1);
  static const Color fhwaveYellow600 = Color.fromRGBO(227, 230, 132, 1);
  static const Color fhwaveYellow700 = Color.fromRGBO(177, 180, 103, 1);
  static const Color fhwaveYellow800 = Color.fromRGBO(137, 139, 80, 1);
  static const Color fhwaveYellow900 = Color.fromRGBO(105, 106, 61, 1);

  /// 'fhwaveNeutral' sind Neutralfarben der fhwave-App,
  /// Die Farben werden als Hintergrundfarben, Schriftfarben usw. verwendet.
  static const Color fhwaveNeutral50 = Color.fromRGBO(239, 240, 240, 1);
  static const Color fhwaveNeutral100 = Color.fromRGBO(206, 208, 210, 1);
  static const Color fhwaveNeutral200 = Color.fromRGBO(182, 185, 188, 1);
  static const Color fhwaveNeutral300 = Color.fromRGBO(149, 153, 157, 1);
  static const Color fhwaveNeutral400 = Color.fromRGBO(129, 133, 138, 1);
  static const Color fhwaveNeutral500 = Color.fromRGBO(97, 103, 109, 1);
  static const Color fhwaveNeutral600 = Color.fromRGBO(88, 94, 99, 1);
  static const Color fhwaveNeutral700 = Color.fromRGBO(69, 73, 77, 1);
  static const Color fhwaveNeutral800 = Color.fromRGBO(53, 57, 60, 1);
  static const Color fhwaveNeutral900 = Color.fromRGBO(41, 43, 46, 1);

  /// Die Farbverläufe sind einige einfache Stilelemente,
  /// die zur visuellen Attraktivität, Tiefe und Hierarchie der
  /// Benutzeroberfläche beitragen können.
  ///
  /// ‘fhwaveBlueGradient’ ist ein blauer bis transparenter Farbverlauf
  static const LinearGradient fhwaveBlueGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [fhwaveBlue500, Color.fromRGBO(250, 250, 250, 0)]);

  /// ‘fhwavePurpleGradient’ ist ein violetter bis transparenter Farbverlauf
  static const LinearGradient fhwavePurpleGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [fhwavePurple700, Color.fromRGBO(250, 250, 250, 0)]);

  /// ‘fhwaveGreenGradient’ ist ein grünner bis transparenter Farbverlauf
  static const LinearGradient fhwaveGreenGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [fhwaveGreen500, Color.fromRGBO(250, 250, 250, 0)]);

  /// ‘fhwaveYellowGradient’ ist ein gelber bis transparenter Farbverlauf
  static const LinearGradient fhwaveYellowGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [fhwaveYellow500, Color.fromRGBO(250, 250, 250, 0)]);

  /// Die unten definierten Container-Widgets werden
  /// für den Hintergrundfarbverlauf der Seite(Screen) verwendet.
  static Container getFhwaveBlueGradientContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 3 / 5,
      decoration: const BoxDecoration(gradient: fhwaveBlueGradient),
    );
  }

  static Container getFhwavePurpleGradientContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 3 / 5,
      decoration: const BoxDecoration(gradient: fhwavePurpleGradient),
    );
  }

  static Container getFhwaveGreenGradientContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 3 / 5,
      decoration: const BoxDecoration(gradient: fhwaveGreenGradient),
    );
  }

  static Container getFhwaveYellowGradientContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 3 / 5,
      decoration: const BoxDecoration(gradient: fhwaveYellowGradient),
    );
  }
}
