[![Build Status](https://travis-ci.org/zoffixznet/perl6-Lingua-Conjunction.svg)](https://travis-ci.org/zoffixznet/perl6-Lingua-Conjunction)

# NAME

Lingua::Conjunction - convert lists into linguistic conjunctions

# SYNOPSIS

```perl6
    use Lingua::Conjunction;

    say conjunction <chair>; # chair
    say conjunction <chair spoon>; # chair and spoon
    say conjunction <chair spoon window>; # chair, spoon, and window

    # "Tom, a man; Tiffany, a woman; and GumbyBRAIN, a bot"
    say conjunction 'Tom, a man', 'Tiffany, a woman', 'GumbyBRAIN, a bot';

    # Reports for May, June, and August
    say conjunction {:str<Report[|s] for |list|>}, <May June August>;

    # "Jacques, un garcon; Jeanne, une fille; et Spot, un chien"
    say conjunction {:lang<fr>},
        'Jacques, un garcon', 'Jeanne, une fille', 'Spot, un chien';

    say ☌ <chair spoon window>; # unicode equivalent
```

# DESCRIPTION

Provides a way to make it easy to prepare a string containing a list of items,
where that string is meant to be read by a human.

# EXPORTED SUBROUTINES

## `conjunction`

## `☌`

    say ☌ <foo bar baz>.

`U+260C (e2 98 8c): CONJUNCTION [☌]`. Same as [`conjunction`](#conjunction)

# REPOSITORY

Fork this module on GitHub:
https://github.com/zoffixznet/perl6-Lingua-Conjunction

# BUGS

To report bugs or request features, please use
https://github.com/zoffixznet/perl6-Lingua-Conjunction/issues

# AUTHOR

This module was heavily inspired by Perl 5's
[Lingua::Conjunction](https://metacpan.org/pod/Lingua::Conjunction) and
and my own
[List::ToHumanString](https://metacpan.org/pod/List::ToHumanString). Some
of the internal data was shamelessly ~~stolen~~ borrowed from
[Lingua::Conjunction](https://metacpan.org/pod/Lingua::Conjunction)'s guts.

The rest is by Zoffix Znet (http://zoffix.com/)

# LICENSE

You can use and distribute this module under the terms of the
The Artistic License 2.0. See the `LICENSE` file included in this
distribution for complete details.
