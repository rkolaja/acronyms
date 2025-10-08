#!/usr/bin/perl

# +----------------------------------------------------------------------------+
# | Copyright (C) 2025 Robert Kolaja                                           |
# |                                                                            |
# | This program is free software; you can redistribute it and/or modify       |
# | it under the terms of the GNU General Public License as published by       |
# | the Free Software Foundation; either version 2 of the License, or          |
# | (at your option) any later version.                                        |
# |                                                                            |
# | This program is distributed in the hope that it will be useful,            |
# | but WITHOUT ANY WARRANTY; without even the implied warranty of             |
# | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              |
# | GNU General Public License for more details.                               |
# |                                                                            |
# | You should have received a copy of the GNU General Public License along    |
# | with this program; if not, write to the Free Software Foundation, Inc.,    |
# | 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.                |
# +----------------------------------------------------------------------------+

use 5.032;
use strict;
use warnings;
use Carp;

use FindBin qw($RealBin);
use lib "$RealBin/local/lib/perl5";
use File::Slurp qw(read_file);

my $inputFile = $ARGV[0];

if (!defined $inputFile)
{
    croak 'No input defined';
}
elsif (!-r $inputFile)
{
    croak 'Input not readable';
}

my $buffer;
my @lines =
  read_file($inputFile, chomp => 1, buf_ref => \$buffer, binmode => ':raw');

my %acronyms = ();

foreach my $line (@lines)
{
    my @words = split(/[\s\/]+/s, $line);

    foreach my $word (@words)
    {
        next unless $word =~ /[[:upper:]]{2}/s;
        $word =~ s/[().,?:;\[\]]//gs;
        my $before = $word;
        $word =~ s/[^\w\-=<>]//gs;

        # if ($before ne $word)
        # {
        #     print {*STDERR} "BEFORE: ${before}; AFTER: ${word}\n";
        # }
        $acronyms{$word}++;
    }
}

# Remove the plural form of a given acronym and add its total to the singular
foreach my $acronym (sort { lc $a cmp lc $b } keys %acronyms)
{
    if (!defined $acronyms{$acronym})
    {
        # print {*STDERR} "${acronym} not defined!\n";
        next;
    }
    if (defined $acronyms{ $acronym . 's' })
    {
        $acronyms{$acronym} += $acronyms{ $acronym . 's' };
        delete $acronyms{ $acronym . 's' };
    }
}

foreach my $acronym (sort { lc $a cmp lc $b } keys %acronyms)
{
    print sprintf("%s,%d\n", $acronym, $acronyms{$acronym}) or croak;
}
