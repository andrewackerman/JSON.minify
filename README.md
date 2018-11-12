# JSON minify

A port of the JSON-minify utility to the Dart language.

## Overview

Minify blocks of JSON-like content into valid JSON by removing all white-space *and* C/C++ style comments.

JSON parsers (like JavaScript's `JSON.parse()` parser) generally don't consider JSON with comments to be valid and parseable. So, the intended usage is of this project is to minify development-friendly JSON (i.e with comments) to valid JSON before parsing, such as:

```dart
JSON.parse(JSON.minify(str))
```

Now you can maintain development-friendly JSON documents, where your source is formatted & commented, but minify them before parsing or before transmitting them over-the-wire.

As transmitting bloated (ie, with comments/white-space) JSON would be wasteful and silly, this JSON minify can also be used for server-side processing environments where you can strip comments/white-space from JSON before parsing a JSON document or before transmitting such over-the-wire from server to browser.

Though comments are not officially part of the JSON standard, [this][yahoo-groups-link] post from Douglas Crockford back in late 2005 helps explain the motivation behind this project.

> A JSON encoder MUST NOT output comments. A JSON decoder MAY accept and ignore comments.

Basically, comments are not in the JSON *generation* standard, but that doesn't mean that a parser can't be taught to ignore them. Which is exactly what JSON minify is for.

## Installation

You can install JSON.minify by adding it to your pubspec.yaml file:

```yaml
json_minify: "^1.0.0"
```

## Usage

To use JSON.minify, import the library and call the `minify` method:

```dart
import 'package:json_minify/minify.dart' as Minify;

...

final minifiedString = Minify.minify(jsonString);
```

## License

The code and all documentation are released under the MIT license.

http://getify.mit-license.org/

