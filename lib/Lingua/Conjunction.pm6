unit package Lingua::Conjunction:ver<1.001001>;

# This handy table was borrowed from
# https://metacpan.org/pod/Lingua::Conjunction
my %language =
    af => { sep => ',', alt => ";", pen => 1, con => 'en',  dis => 'of'    },
    da => { sep => ',', alt => ";", pen => 1, con => 'og',  dis => 'eller' },
    de => { sep => ',', alt => ";", pen => 1, con => 'und', dis => 'oder'  },
    en => { sep => ',', alt => ";", pen => 1, con => 'and', dis => 'or'    },
    es => { sep => ',', alt => ";", pen => 1, con => 'y',   dis => 'o'     },
    fi => { sep => ',', alt => ";", pen => 1, con => 'ja',  dis => 'tai'   },
    fr => { sep => ',', alt => ";", pen => 0, con => 'et',  dis => 'ou'    },
    it => { sep => ',', alt => ";", pen => 1, con => 'e',   dis => 'o'     },
    la => { sep => ',', alt => ";", pen => 1, con => 'et',  dis => 'vel'   },
    nl => { sep => ',', alt => ';', pen => 1, con => 'en',  dis => 'of'    },
    no => { sep => ',', alt => ";", pen => 0, con => 'og',  dis => 'eller' },
    pt => { sep => ',', alt => ";", pen => 1, con => 'e',   dis => 'ou'    },
    sw => { sep => ',', alt => ";", pen => 1, con => 'na',  dis => 'au'    },
;

multi conjunction (*@args) is export { conjunction({:lang('en')}, @args) }
multi conjunction (Hash $args, *@args) is export {  }
sub term:<☌> (*@args ) is export {}
    # = ::('&conjunction');
