import 'package:test/test.dart';

import '../lib/minify.dart' as Minify;

void main() {
  test('Test 1', () {
    final input = r'''// this is a JSON file with comments
{
	"foo": "bar",	// this is cool
	"bar": [
		"baz", "bum", "zam"
	],
/* the rest of this document is just fluff
   in case you are interested. */
	"something": 10,
	"else": 20
}

/* NOTE: You can easily strip the whitespace and comments
   from such a file with the JSON.minify() project hosted
   here on github at http://github.com/getify/JSON.minify
*/''';

    final expected = r'{"foo":"bar","bar":["baz","bum","zam"],"something":10,"else":20}';

    expect(Minify.minify(input), expected);
  });

  test('Test 2', () {
    final input = r'''{"/*":"*/","//":"",/*"//"*/"/*/"://
"//"}''';

    final expected = r'{"/*":"*/","//":"","/*/":"//"}';

    expect(Minify.minify(input), expected);
  });

  test('Test 3', () {
    final input = r'''/*
this is a
multi line comment */{

"foo"
:
	"bar/*"// something
	,	"b\"az":/*
something else */"blah"

}''';

    final expected = r'{"foo":"bar/*","b\"az":"blah"}';

    expect(Minify.minify(input), expected);
  });

  test('Test 4', () {
    final input = r'''{"foo": "ba\"r//", "bar\\": "b\\\"a/*z",
	"baz\\\\": /* yay */ "fo\\\\\"*/o"
}''';

    final expected = r'{"foo":"ba\"r//","bar\\":"b\\\"a/*z","baz\\\\":"fo\\\\\"*/o"}';

    expect(Minify.minify(input), expected);
  });
}