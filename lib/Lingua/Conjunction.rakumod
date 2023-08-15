# This handy table was partially borrowed from
# https://metacpan.org/pod/Lingua::Conjunction
my constant %language =
    af => Map.new((  :last,  con => 'en',  dis => 'of'    )),
    da => Map.new((  :last,  con => 'og',  dis => 'eller' )),
    de => Map.new((  :last,  con => 'und', dis => 'oder'  )),
    en => Map.new((  :last,  con => 'and', dis => 'or'    )),
    es => Map.new((  :last,  con => 'y',   dis => 'o'     )),
    fi => Map.new((  :last,  con => 'ja',  dis => 'tai'   )),
    fr => Map.new(( :!last,  con => 'et',  dis => 'ou'    )),
    it => Map.new((  :last,  con => 'e',   dis => 'o'     )),
    la => Map.new((  :last,  con => 'et',  dis => 'vel'   )),
    nl => Map.new((  :last,  con => 'en',  dis => 'of'    )),
    no => Map.new(( :!last,  con => 'og',  dis => 'eller' )),
    pt => Map.new((  :last,  con => 'e',   dis => 'ou'    )),
    sw => Map.new((  :last,  con => 'na',  dis => 'au'    )),
;

my sub conjunction (
    *@els,
    Str:D  :$lang                     = 'en',
    Str:D  :$sep is copy              = ',',
    Str:D  :$alt                      = ';',
    Str:D  :$con                      = %language{ $lang }<con>,
    Str:D  :$dis                      = %language{ $lang }<dis>,
    Bool:D :$last                     = %language{ $lang }<last>,
    Str:D  :$type where any(<and or>) = 'and',
    Str:D  :$str                      = '|list|',
--> Str:D) is export {
    my $sep-word := $type eq 'and' ?? $con !! $dis;
    $sep = $alt if @els.grep(/$sep/);

    my $list = do given @els.elems {
        when 0 { ''                       }
        when 1 { @els[0]                  }
        when 2 { @els.join(" $sep-word ") }
        default {
            @els[0..*-2].join("$sep ")
            ~ "{$last ?? $sep !! ''} $sep-word @els[*-1]";
        }
    }

    $str
      .subst(
        / '[' (<-[|]>*) '|' (<-[\]]>*) ']'/,
        { @els.elems == 0 || @els.elems > 1 ?? $1 !! $0 }, :g
      )
      .subst('|list|', $list, :g)
}

=begin pod

=head1 NAME

Lingua::Conjunction - Convert lists into linguistic conjunctions and fill them into a template

=head1 SYNOPSIS

=begin code :lang<raku>

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

=end code

=head1 DESCRIPTION

Provides a way to make it easy to prepare a string containing a list of items,
where that string is meant to be read by a human.

=head1 EXPORTED SUBROUTINES

=head2 conjunction

=begin code :lang<raku>

say conjunction <chair spoon>;
say conjunction <May June August>, :str('Report[|s] for |list|'),
    :lang<fr>, :!last, :sep<·>, :alt<°>, :con<aaand>, :dis<ooor>, :type<or>;

=end code

Returns a string with the given list of items joined based on the
configuration specified by the named arguments, which are as follows:

=head3 alt

Specifies an alternative separator to use when at least one of the items
contains C<sep> separator. B<Defaults to> C<;> (a semicolon).

head3 con

Short for B<con>junction. The term to use when joining the last item
to the previous one, when C<type> argument is set to value C<and>.
B<By default> is set based on value of C<lang> argument.

=head3 dis

Short for B<dis>junction. The term to use when joining the last item
to the previous one, when C<type> argument is set to value C<or>.
B<By default> is set based on value of C<lang> argument.

=head3 lang

Takes a string representing the code of the language to use. This will
pre-set C<con>, C<dis>, and C<last> arguments. B<Defaults to> C<en>.
Currently supported languages and the defaults they pre-set are as follows
(language is the first two-letter key on the left; that's what you'd
specify as C<lang> argument):

=begin table
lang | last  | con | dis |
-----|-------|-----|-----|
af   | True  | en  | of
da   | True  | og  | eller
de   | True  | und | oder
en   | True  | and | or
es   | True  | y   | o
fi   | True  | ja  | tai
fr   | False | et  | ou
it   | True  | e   | o
la   | True  | et  | vel
nl   | True  | en  | of
no   | False | og  | eller
pt   | True  | e   | ou
sw   | True  | na  | au
=end table

=head3 last

Specifies whether to use C<sep> when joining the penultimate and last elements
of the list, when the number of elements is more than 2. In English, this
is what's known as L<Oxford Comma|https://en.wikipedia.org/wiki/Serial_comma>.
B<By default> is set based on value of C<lang> argument.

=head3 sep

The primary item separator to use. B<Defaults to> C<,> (a comma).

=head3 str

=begin code :lang<raku>

say conjunction <May June August>, :str('Report[|s] for |list|');
say conjunction <Squishy Slushi Sushi>,
    :str('Octop[us|i] [is|are] named |list|');

=end code

Specifies a template to use when generating the string. You can use
special sequence C<[|]> (e.g. C<octop[us|i]>) where string to the left of
the C<|> will be used when the list contains just one item and the string to
the right will be used otherwise. The other special sequence is
C<|list|> that will be replaced with the "conjuncted" items of the list.
B<Defaults to> C<|list|>.

=head3 type

Takes either value C<and> or value C<or>. Specifies whether words
specified by C<con> or by C<dis> arguments should be used when joining the
last two elements of the list.

=head1 AUTHOR

This module was inspired by Perl's
L<Lingua::Conjunction|https://metacpan.org/pod/Lingua::Conjunction> and
and L<List::ToHumanString|https://metacpan.org/pod/List::ToHumanString>.
Some of the internal data was shamelessly ~~stolen~~ borrowed from
L<Lingua::Conjunction|https://metacpan.org/pod/Lingua::Conjunction>'s guts.

The rest is by Zoffix Znet (http://zoffix.com/)

=head1 COPYRIGHT AND LICENSE

Copyright 2015 - 2017 Zoffix Znet

Copyright 2018 - 2023 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
