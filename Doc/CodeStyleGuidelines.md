# StyleGuide für AEM-Projekt

## Grundregeln

- ##### Codesprache ist Englisch!
- ##### Kommentare und Commits werden auf deutsch geschrieben!
- ##### Eindeutige sprechende Namen!
- ##### Kommentiere so viel wie nötig, so wenig wie möglich!
- ##### try-catch-Blöcke müssen benutzt werden
- ##### Commit-Nachrichten müssen eindeutig sein
- ##### Design Pattern wird eingehalten!
- ##### *flutter analyze .* und *dart format .* **VOR** dem merge-request ausführen


<br>Generell sollen alle **DO** und **DON'T** von den [Dart Style Guide] umgesetzt werden.<br>


## Style

Klassen, Enum Typen, Typdefinition (typedef), Typ Parameter &lt;T&gt;, Extensions <br>
werden in **UpperCamelCase** geschrieben. <br>

```c
Beispiel:

class Klasse { ... }

typedef Predicate<T> = bool Function(T value);

```

Packages, Directories, Quelldateien, Import Variablen Namen  <br>
werden als **lowercase_with_underscores** geschrieben.

```javascript
Beispiel:

my_package
└─ lib
   └─ file_system.dart
   └─ slider_menu.dart

import 'dart:math' as math;
import 'package:angular_components/angular_components.dart' as angular_components;
import 'package:js/js.dart' as js;

```

Funktionen, Methoden, Variablen, Attribute, Parameter <br>
werden als **lowerCamelCase** geschrieben

```javascript
Beispiel:

var count = 3;

HttpRequest httpRequest;

void align(bool clearItems) {
  // ...
}
```

Konstante <br>
werden als **SCREAMING_CAPS** geschrieben?

```javascript
Beispiel:

const PI = 3.14;
const DEFAULT_TIMEOUT = 1000;
final URL_SCHEME = RegExp('^([a-z]+):');

class Dice {
  static final NUMBER_GENERATOR = Random();
}

```

Abkürzungen gelten als ein Wort.

```javascript
class HttpConnection {}
class DBIOPort {}
class TVVcr {}
class MrRogers {}

var httpRequest = ...
var uiHandler = ...
var userId = ...
Id id;
```


## Dokumentation

### Kommentare
- Kommentiere auf deutsch
- Kommentiere in vollen Sätzen
- Benutze keine Block-Kommentare
- Benutze /// um ein Kommentar für die Dokumentation zu schreiben. Diese können später automatisch in die Dokumentation. 
- ##### Kommentiere so viel wie nötig, so wenig wie möglich!

Die Dokumentation muss up to date gehalten werden und am besten auch im Code festgehalten. Das vereinfacht die Wartung.

## Nutzung
Falls gewisse Nutzungstechniken auffallen, die man lassen oder nutzen sollte, können diese hier dokumentiert werden.

#### Formatierung
Verwendung von Einrückungen für Blöcke und Schleifen <br>
Verwendung von Klammern für alle Blöcke, auch bei Einzeilern <br>
Verwendung von Leerzeichen zwischen Operatoren und Variablen <br>
Verwendung von Leerzeilen zwischen Methoden und Klassen


#### Variablen und Typen
Verwendung von final oder const für unveränderliche Variablen <br>
Verwendung von dynamischen Typen nur wenn notwendig <br>
Verwendung von Typ-Annotationen, um den Code klarer und lesbarer zu machen <br>
Vermeidung von Var wenn der Typ offensichtlich ist 

#### Methoden und Funktionen
Verwendung von sprechenden Namen für Methoden und Funktionen <br>
Vermeidung von Methoden mit mehr als 15 Zeilen Code <br>
Verwendung von void, wenn die Methode keine Rückgabe hat <br>
Verwendung von async/await statt then()-Funktionen

#### Flutter-spezifische Empfehlungen
Verwendung von Widgets als eigenständige Klassen <br>
Verwendung von MaterialApp oder CupertinoApp als Basis der App <br>
Verwendung von StatelessWidget und StatefulWidget <br>
Verwendung von ListView.builder() anstelle von ListView()



## Design

Falls gewisse Namensgebungen, Formatierungen, Syntax auffallen, die man lassen oder nutzen sollte, können diese hier dokumentiert werden.


## Design Pattern

## MVC
[Model-View-Controller (MVC)]

## Benennung

Konsistenz in der Namensgebung <br>
Vermeide reservierte Wörter <br>
Verwende beschreibende Namen <br>
Vermeide zu lange Namen<br>

Benennungs-Stile von lokalen-, globalen Variablen, Packages, Library und sonstigem: <br>

Lokale Variablen: aussagekräftige Namen, camelCase (z.B. userName)<br>
Globale Variablen: eindeutige, aussagekräftige Namen, Konstanten in Großbuchstaben (z.B. MAX_SIZE)<br>
Packages: eindeutige, beschreibende Namen, Großbuchstaben und Unterstriche (z.B. my_first_package)<br>
Libraries: beschreibende Namen, Großbuchstaben und Unterstriche (z.B. my_library)

## Testen

Try Catch muss eingesetzt werden. 

## GIT-Guide

Commit Sprache ist deutsch.

Branch Namen werden in drei Bereiche geteilt und mit Unterstrichen getrennt. Es wird als **UpperCamelCase** geschrieben. <br>
Struktur: <br>
Feature_Funktion_Name <br>

Es gibt einen Master-Branch, einen Develop-Branch und verschiede Feature-Branches.
Von den Features wird nur in den Develop-Branch gemergt, der Develop-Branch ist der einzige der in den Master-Branch mergt. 
Es kann immer vom Develop-Branch gemergt werden, um seinen eigene Branch zu aktualisieren.

Jeder Commit muss mit einem eindeutigen Namen versehen sein.

Commit Anfangs-Kürzel:

Docu_ *um Dokumentation zu ändern*
Env_ *um etwas an dem Entwicklungsvorgang zu ändern*  
Feature_ *ein neues Feature hinzufügen*
UpdateFeature_ *ein Feature updaten*
Fix_ *einen Fix zu machen, unschöne Stellen ändern*
BugFix_ *einen Fehler beheben*
UI_ *Aussehen wird angepasst*
Backend_ *Backend, Datenbank wird angepasst*
Firebase_ *LogIn Dateien oder ähnliches wird angepasst*



Beispiel:

```javascript
Beispiel: 

| | |
| | |
| |/|  
| | |
| | |
| | |
|\  |
| | * //Feature_LoginSide_Max
| |/
| |\
| | |
| | * //Feature_ButtonToSwitchFromStartPageToMainPage_Max
| |/
| | 
| * //Develop
|/
* //Master
``` 





[Dart Style	Guide]: https://dart.dev/guides/language/effective-dart
[Model-View-Controller (MVC)]: https://medium.com/p/1fabe2069b01