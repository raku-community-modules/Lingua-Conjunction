[![Actions Status](https://github.com/raku-community-modules/Lingua-Conjunction/actions/workflows/linux.yml/badge.svg)](https://github.com/raku-community-modules/Lingua-Conjunction/actions) [![Actions Status](https://github.com/raku-community-modules/Lingua-Conjunction/actions/workflows/macos.yml/badge.svg)](https://github.com/raku-community-modules/Lingua-Conjunction/actions) [![Actions Status](https://github.com/raku-community-modules/Lingua-Conjunction/actions/workflows/windows.yml/badge.svg)](https://github.com/raku-community-modules/Lingua-Conjunction/actions)

NAME
====

Lingua::Conjunction - Convert lists into linguistic conjunctions and fill them into a template

SYNOPSIS
========

```raku
use Lingua::Conjunction;

say conjunction <chair>; # chair
say conjunction <chair spoon>; # chair and spoon
say conjunction <chair spoon window>; # chair, spoon, and window

# "Tom, a man; Tiffany, a woman; and GumbyBRAIN, a bot"
say conjunction 'Tom, a man', 'Tiffany, a woman', 'GumbyBRAIN, a bot';

# These are reports for May, June, and August
say conjunction <May June August>, :str('These [is|are] report[|s] for |list|');

# "Jacques, un garcon; Jeanne, une fille et Spot, un chien"
say conjunction 'Jacques, un garcon', 'Jeanne, une fille', 'Spot, un chien',
    :lang<fr>;
```

DESCRIPTION
===========

Provides a way to make it easy to prepare a string containing a list of items, where that string is meant to be read by a human.

EXPORTED SUBROUTINES
====================

conjunction
-----------

```raku
say conjunction <chair spoon>;
say conjunction <May June August>, :str('Report[|s] for |list|'),
    :lang<fr>, :!last, :sep<·>, :alt<°>, :con<aaand>, :dis<ooor>, :type<or>;
```

Returns a string with the given list of items joined based on the configuration specified by the named arguments, which are as follows:

### alt

Specifies an alternative separator to use when at least one of the items contains `sep` separator. **Defaults to** `;` (a semicolon).

head3 con

Short for **con**junction. The term to use when joining the last item to the previous one, when `type` argument is set to value `and`. **By default** is set based on value of `lang` argument.

### dis

Short for **dis**junction. The term to use when joining the last item to the previous one, when `type` argument is set to value `or`. **By default** is set based on value of `lang` argument.

### lang

Takes a string representing the code of the language to use. This will pre-set `con`, `dis`, and `last` arguments. **Defaults to** `en`. Currently supported languages and the defaults they pre-set are as follows (language is the first two-letter key on the left; that's what you'd specify as `lang` argument):

<table class="pod-table">
<thead><tr>
<th>lang</th> <th>last</th> <th>con</th> <th>dis</th> <th></th>
</tr></thead>
<tbody>
<tr> <td>af</td> <td>True</td> <td>en</td> <td>of</td> <td></td> </tr> <tr> <td>da</td> <td>True</td> <td>og</td> <td>eller</td> <td></td> </tr> <tr> <td>de</td> <td>True</td> <td>und</td> <td>oder</td> <td></td> </tr> <tr> <td>en</td> <td>True</td> <td>and</td> <td>or</td> <td></td> </tr> <tr> <td>es</td> <td>True</td> <td>y</td> <td>o</td> <td></td> </tr> <tr> <td>fi</td> <td>True</td> <td>ja</td> <td>tai</td> <td></td> </tr> <tr> <td>fr</td> <td>False</td> <td>et</td> <td>ou</td> <td></td> </tr> <tr> <td>it</td> <td>True</td> <td>e</td> <td>o</td> <td></td> </tr> <tr> <td>la</td> <td>True</td> <td>et</td> <td>vel</td> <td></td> </tr> <tr> <td>nl</td> <td>True</td> <td>en</td> <td>of</td> <td></td> </tr> <tr> <td>no</td> <td>False</td> <td>og</td> <td>eller</td> <td></td> </tr> <tr> <td>pt</td> <td>True</td> <td>e</td> <td>ou</td> <td></td> </tr> <tr> <td>sw</td> <td>True</td> <td>na</td> <td>au</td> <td></td> </tr>
</tbody>
</table>

### last

Specifies whether to use `sep` when joining the penultimate and last elements of the list, when the number of elements is more than 2. In English, this is what's known as [Oxford Comma](https://en.wikipedia.org/wiki/Serial_comma). **By default** is set based on value of `lang` argument.

### sep

The primary item separator to use. **Defaults to** `,` (a comma).

### str

```raku
say conjunction <May June August>, :str('Report[|s] for |list|');
say conjunction <Squishy Slushi Sushi>,
    :str('Octop[us|i] [is|are] named |list|');
```

Specifies a template to use when generating the string. You can use special sequence `[|]` (e.g. `octop[us|i]`) where string to the left of the `|` will be used when the list contains just one item and the string to the right will be used otherwise. The other special sequence is `|list|` that will be replaced with the "conjuncted" items of the list. **Defaults to** `|list|`.

### type

Takes either value `and` or value `or`. Specifies whether words specified by `con` or by `dis` arguments should be used when joining the last two elements of the list.

AUTHOR
======

This module was inspired by Perl's [Lingua::Conjunction](https://metacpan.org/pod/Lingua::Conjunction) and and [List::ToHumanString](https://metacpan.org/pod/List::ToHumanString). Some of the internal data was shamelessly ~~stolen~~ borrowed from [Lingua::Conjunction](https://metacpan.org/pod/Lingua::Conjunction)'s guts.

The rest is by Zoffix Znet (http://zoffix.com/)

COPYRIGHT AND LICENSE
=====================

Copyright 2015 - 2017 Zoffix Znet

Copyright 2020 - 2024 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

