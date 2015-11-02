# JSONTransform

JSONTransform is a declarative language for transforming JSON objects based on pattern matching, destructuring, and selector languages.

A JSONTransform document is a kind of template that uses pattern matching to populate values.  When applying a JSONTransform to a JSON object, Strings in the transform document that start with = are interpreted as JSONSelect selectors, and replaced with the selected results from the object.  There is also a expression language, and language bindings to allow functions from the host language to be called.

When matching the object
```JSON
{
  "name": {
    "first": "Marty",
    "fast": "Gentillon"
  },
  "address": {
    "street": "00000 Fake St.",
    "city": "Seattle",
    "state": "WA",
    "zip": 99999
  }
}
```

Against the JSONTransform
```JSONTransform
{
  "Name": ["@join", " ", "=.name.first", "=.name.last"],
  "Address": ["@join", "\n",
    "=address.Street",
    ["@join", " ", "=.address.city", "=.address.state", "=.address.zip"]]
}
```

will produce

```JSON
{
  "Name": "Marty Gentillon",
  "Address": "0000 Fake St.\nSeattle WA 99999"
}
```

Principles:
1) the output should look like the input
2) The JSONTransform document is a JSON document


strings are indicated with the / sigil, which will be removed from the front.  Additionally, strings with no recognized, or reserved sigil will be treated as strings as is.

Language callbacks are indicated with the % sigil at the beginning of an array. They may be implemented various ways.

Input
```JSON
{
  "subject": "test",
  "body": "blah blah",
  "bad data": "evil"
}
```

```JSONTransform
{"@keys": ["subject", "body"]}
```

or
```JSONTransform
{"@remove-keys": ["bad data"]}
```

output
```JSON
{
  "subject": "test",
  "body": "evil"
}
```


Input
```JSON
[["key1", "value1"],
["key2", "value2"]]
```

```JSONTransform
["@assoc", ":root"]
```

```JSON
{
  "key1": "value1",
  "key2": "value2"
}
```



operations:
[@join, on, *values]
[@assoc, list-to-assoc, key-selector default :first-child, value-selector default :nth-child(2)] <# needs a better name #>
[@deassoc, map-to-deassoc, value-template default ["@key", "@value"]]
[@transform-in, document-to-transform, selector-to-apply-sub-transform-on, sub-tranform]
[@concat, *collections-to-join]
[@group-by, collection-to-group, key-selector]
[@transform, document-to-transform, sub-transform]
[@union, *documents-to-unionize] <# how to handle collisions? choose first? #>
?[@select]
?[@reject]
? comparison, tests, and math operators

special keys:
@keys
@remove-keys
@as
@remaining

variables?  maybe using _, or just using @ syntax