# Wichtige Informationen für Entwickler

## Inhaltsverzeichnis

- [Auschecken des Quellcodes](#auschecken-des-quellcodes)
- [Benötigte Tools für die Entwicklung](#benötigte-tools-für-die-entwicklung)
- [Datenbank mit Firebase](#datenbank-mit-firebase)
- [Verwendung von Farben](#verwendung-von-farben)
- [Schritte zur fertigen Installation der App](#schritte-zur-fertigen-installation-der-app)
- [Weitere Ressourcen](#weitere-ressourcen)

## Auschecken des Quellcodes
### Voraussetzungen


- [Git](https://git-scm.com/downloads) ist auf Ihrem Rechner installiert.
- Eine IDE ist installiert, die sich gut für die Entwicklung mit Flutter eignet. Empfohlen werden IntelliJ IDEA, Android Studio und Visual Studio Code. Im Folgenden wird [Android Studio](https://developer.android.com/studio) als Beispiel verwendet.

### Schritte zum Auschecken des Quellcodes
Es gibt zwei Möglichkeiten, dies zu erreichen

**Mit der Kommandozeile**
- Navigieren Sie zu dem lokalen Ordner, in dem Sie das Projekt klonen möchten
- Geben Sie den folgenden Befehl ein:
```sh
git clone https://gitlab.iue.fh-kiel.de/aem_2023/team-9/app.git
```

- Öffnen Sie Android Studio, wählen Sie "Open an Existing Project" und navigieren Sie zum Ordner des geklonten Projekts.

**Über die IDE**
- Kopieren Sie die URL: `https://gitlab.iue.fh-kiel.de/aem_2023/team-9/app.git`
- Öffnen Sie Android Studio und wählen Sie "Get from Version Control" auf dem Willkommensbildschirm oder "File" > "New" > "Project from Version Control" im Hauptmenü, wenn Sie bereits ein Projekt geöffnet haben.
- Dann fügen Sie die zuvor kopierte URL ein. Klicken Sie anschließend auf "Klonen".



## Benötigte Tools für die Entwicklung

**Flutter SDK:** Installieren Sie [Flutter SDK](https://docs.flutter.dev/get-started/install). Befolgen Sie die Anweisungen für Ihr Betriebssystem auf der offiziellen Flutter-Website.

**Android Studio & Android SDK:** Um eine Android-App mit Flutter zu entwickeln. Es wird empfohlen, [Android Studio](https://developer.android.com/studio) zu installieren, obwohl Sie eine andere IDE verwenden.

**Flutter- & Dart-Plugins:** Sie müssen auch die Flutter- und Dart-Plugins für Android Studio installieren "Navigieren Sie zur Settings" > "Plugins", um Flutter-Apps zu entwickeln und zu debuggen.

**Xcode (nur macOS):** Wenn Sie iOS-Apps entwickeln möchten, müssen Sie [Xcode](https://developer.apple.com/xcode/) auf Ihrem Mac installieren.

**Emulatoren oder physische Geräte:** Sie benötigen entweder Emulatoren (Android und/oder iOS) oder physische Geräte(nur Android möglich), um Ihre Flutter-Apps auszuführen und zu testen. Siehe jeweils die Dokumentation, um einen Emulator/Simulator zu erstellen

## Datenbank mit Firebase


## Verwendung von Farben
Die Farbspezifikation ist gemäß dem Material Design von Google definiert. Von 50 bis 900 sind diese Farben in der Reihenfolge von heller zu dunkler angeordnet und können verwendet werden, um eine einheitliche und ästhetisch ansprechende Benutzeroberfläche zu schaffen. Die gesamte Darstellung von allen Farben finden Sie [auf Figma](https://www.figma.com/file/2BIHFaTz4u4FBwlu6wyJzK/AEM?type=design&node-id=0%3A1&t=I1BSBydlBKw9DLqy-1).

In Material Design, die Nummer "500" in der Farbnummerierung repräsentiert das Standardniveau der Farbe. Diese Stufe steht für eine mittlere Sättigung und Helligkeit und wird in der Regel als Standardwert für die Farbe verwendet.

Es gibt eine Klasse **AppColors** unter "lib" > "app_colors.dart", die alle Farben enthält, die für die fhwave-App benötigt werden.
Bitte beachten Sie, dass für die Schriftfarben nur black oder fhwaveNeutral[nummer] verwendet werden darf.

### Wie zu verwenden:

- Klassen importieren: z.B. `import '../app_colors.dart';` 
- `AppColors.[Farbbezeichnung]` z.B. `AppColors.fhwaveBlue500`

## Verwendung von Buttons
Wir haben die folgenden Buttons für unsere App definiert:

**fhwave-Primary-Button** ist ein primärer Button-Stil. Hier sind einige Beispiele für die Einsatzung: Aktionen mit höherer Priorität. Bestimmte Aktivitäten, zu denen Wir den Nutzer veranlassen möchten. z.B. "Bestätigen", "Löschen", "Speichern","Weiter", "Anmelden" usw.

**fhwave-Primary-Button-With-Icon** ist ein primärer Button-Stil mit einem Icon. Hauptsächlich zur besseren visuellen Darstellung des Zwecks der Button verwendet. Hier sind eine Beispiel für die Einsatzung: "+ Hinzufügen"

**fhwave-Secondary-Button** ist ein Wireframe sekundärer Button-Stil. Beispiele für die Einsatzung: Bei Sekundärer Optionen/ Alternativer Aktionen. Bei zwei Aktionen mit unterschiedlicher Priorität. "Abbrechen". Auchte darauf, dass "Abbrechen" auch Prämier Button sein kann, wenn wir den Nutzer zu "Abbrechen" veranlassen möchten, um Fehlbedienung zu verhindern. z.B. bei dem Löschen/Auflösen der Gruppe.

**fhwave-Quick-Link-Button** ist für Quicklinks definiert.

### Wie zu verwenden:
Wir nehmen Primary Button als Beispiel:
- Importiere die Datei, in der sich die Primary Button Klasse befindet. z.B. `import 'widgets/buttons/primary_button.dart';`
- Übergib den Text für den Button an das `text`-Attribut des PrimaryButton-Widgets.
- Übergib die entsprechende Funktion an das `onTap`-Attribut des PrimaryButton-Widgets.
- Optinal können Sie selbe die Breite und Höhe des Buttons definieren, indem Sie `width`-Attribut und `height`-Attribut übergeben.
- Platzieren Sie das PrimaryButton-Widget an der gewünschten Stelle in Ihrem Flutter-Layout, z. B. innerhalb einer `Column` oder `Row`.

## Schritte zur fertigen Installation der App

**Android**

- Aktualisieren Sie die Version und den Build-Nummern in "pubspec.yaml" und "android/app/build.gradle" Dateien entsprechend den Änderungen in Ihrer App.
- Öffnen Sie die Konsole und führen Sie den folgenden Befehl aus, um ein Release-Build Ihrer App für Android zu erstellen: `flutter build apk --release`
- Der Release-Build wird im Ordner "build/app/outputs/flutter-apk/" generiert.
- Um die App auf einem angeschlossenen Gerät oder Emulator zu installieren, führen Sie den folgenden Befehl aus: `flutter install`
- Wenn Sie die App im Google Play Store veröffentlichen möchten, müssen Sie eine signierte Version der APK erstellen. Folgen Sie den Anweisungen in der [offiziellen Flutter-Dokumentation](https://flutter.dev/docs/deployment/android).

**iOS**

- Aktualisieren Sie die Version und den Build-Nummern in "pubspec.yaml" und "ios/Runner.xcodeproj/project.pbxproj" Dateien entsprechend den Änderungen in Ihrer App.
- Öffnen Sie Xcode und wählen Sie das Menü "Product" > "Scheme" > "Runner".
- Wählen Sie "Product" > "Destination" > "Generic iOS Device" oder ein bestimmtes iOS-Gerät aus der Liste.
- Wählen Sie Product > Archive, um die App zu archivieren.
- Nachdem die Archivierung abgeschlossen ist, öffnet sich der Organizer. Wählen Sie das Archiv und klicken Sie auf Distribute App, um den Prozess der Veröffentlichung im App Store zu starten.
- Befolgen Sie die Anweisungen in der [offiziellen Flutter-Dokumentation](https://flutter.dev/docs/deployment/ios), um Ihre App im App Store/Testflight zu veröffentlichen.

## Weitere Ressourcen
Weitere Informationen zur Entwicklung von Flutter-Apps finden Sie in der [offiziellen Dokumentation](https://flutter.dev/docs).
