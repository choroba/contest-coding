#!/usr/bin/perl
use warnings;
use strict;

use constant SHIFT => 16;

my $end = chr SHIFT - 1 + ord 'a';
my $start = $end; $start++;
my $translate = "/$start-za-$end/a-z/";

while (<DATA>) {
    eval "y$translate;y\U$translate";
    print;
}

__DATA__
Yj mqi jxu ruij ev jycui, yj mqi jxu mehij ev jycui, yj mqi jxu qwu ev
myitec, yj mqi jxu qwu ev veebyixduii, yj mqi jxu ufesx ev rubyuv, yj
mqi jxu ufesx ev ydshutkbyjo, yj mqi jxu iuqied ev Bywxj, yj mqi jxu
iuqied ev Tqhaduii, yj mqi jxu ifhydw ev xefu, yj mqi jxu mydjuh ev
tuifqyh, mu xqt uluhojxydw ruvehu ki, mu xqt dejxydw ruvehu ki, mu
muhu qbb weydw tyhusj je Xuqlud, mu muhu qbb weydw tyhusj jxu ejxuh
mqo – yd ixehj, jxu fuhyet mqi ie vqh byau jxu fhuiudj fuhyet, jxqj
iecu ev yji deyiyuij qkjxehyjyui ydiyijut ed yji ruydw husuylut, veh
weet eh veh ulyb, yd jxu ikfuhbqjylu tuwhuu ev secfqhyied edbo.
