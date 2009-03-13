
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Data-Rx-TypeBundle-Perl',
  NAME      => 'Data::Rx::TypeBundle::Perl',
  AUTHOR    => 'Ricardo\ SIGNES\ \<rjbs\@cpan\.org\>',
  ABSTRACT  => 'experimental / perl object type',
  VERSION   => '0.003',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.21) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "Scalar::Util" => '0',
    "Data::Rx" => '0.005',
  },
);
