String minify(String jsonString) {
  final tokenizer = new RegExp(r'"|(\/\*)|(\*\/)|(\/\/)|\n|\r/g');
  final escapeSlashes = new RegExp(r'(\\)*$');

  var inString = false;
  var inMultilineComment = false;
  var inSinglelineComment = false;
  var newStr = new StringBuffer();
  var from = 0;
  var tmp, tmp2, lc, rc;

  final matches = tokenizer.allMatches(jsonString);
  for (var match in matches) {
    lc = jsonString.substring(0, match.start);
    rc = jsonString.substring(match.end, jsonString.length);
    tmp = jsonString.substring(match.start, match.end);

    if (!inMultilineComment && !inSinglelineComment) {
      tmp2 = lc.substring(from);
      if (!inString) {
        tmp2 = tmp2.replaceAll(new RegExp(r'(\n|\r|\s)*'), '');
      }
      newStr.write(tmp2);
    }

    from = match.end;

    if (tmp[0] == '"' && !inMultilineComment && !inSinglelineComment) {
      tmp2 = escapeSlashes.firstMatch(lc).group(0);
      if (!inString || tmp2 == null || (tmp2.length % 2) == 0) {
        inString = !inString;
      }
      from--;
      rc = jsonString.substring(from);
    } else if (tmp.startsWith('/*') && !inString && !inMultilineComment && !inSinglelineComment) {
      inMultilineComment = true;
    } else if (tmp.startsWith('*/') && !inString && inMultilineComment) {
      inMultilineComment = false;
    } else if (tmp.startsWith('//') && !inString && !inMultilineComment && !inSinglelineComment) {
      inSinglelineComment = true;
    } else if ((tmp.startsWith('\n') || tmp.startsWith('\r')) && !inString && !inMultilineComment && inSinglelineComment) {
      inSinglelineComment = false;
    } else if (!inMultilineComment && !inSinglelineComment && !(new RegExp(r'\n|\r|\s').hasMatch(tmp.substring(0, 1)))) {
      newStr.write(tmp);
    }
  }

  newStr.write(rc);

  return newStr.toString();
}