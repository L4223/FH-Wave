# Auschecken des Quellcodes
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



# Benötigte Tools für die Entwicklung

**Flutter SDK:** Installieren Sie [Flutter SDK](https://docs.flutter.dev/get-started/install). Befolgen Sie die Anweisungen für Ihr Betriebssystem auf der offiziellen Flutter-Website.

**Android Studio & Android SDK:** Um eine Android-App mit Flutter zu entwickeln. Es wird empfohlen, [Android Studio](https://developer.android.com/studio) zu installieren, obwohl Sie eine andere IDE verwenden.

**Flutter- & Dart-Plugins:** Sie müssen auch die Flutter- und Dart-Plugins für Android Studio installieren "Navigieren Sie zur Settings" > "Plugins", um Flutter-Apps zu entwickeln und zu debuggen.

**Xcode (nur macOS):** Wenn Sie iOS-Apps entwickeln möchten, müssen Sie [Xcode](https://developer.apple.com/xcode/) auf Ihrem Mac installieren.

**Emulatoren oder physische Geräte:** Sie benötigen entweder Emulatoren (Android und/oder iOS) oder physische Geräte(nur Android möglich), um Ihre Flutter-Apps auszuführen und zu testen. Siehe jeweils die Dokumentation, um einen Emulator/Simulator zu erstellen


# Schritte zur fertigen Installation der App

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

# Weitere Ressourcen
Weitere Informationen zur Entwicklung von Flutter-Apps finden Sie in der [offiziellen Dokumentation](https://flutter.dev/docs).
