use strict;
use warnings;
package Data::Rx::Type::Perl::Ref;
BEGIN {
  $Data::Rx::Type::Perl::Ref::VERSION = '0.004';
}
# ABSTRACT: experimental / perl reference type


use Carp ();
use Scalar::Util ();

sub type_uri { 'tag:codesimply.com,2008:rx/perl/ref' }

sub new_checker {
  my ($class, $arg, $rx) = @_;
  $arg ||= {};

  for my $key (keys %$arg) {
    next if $key eq 'referent';
    Carp::croak(
      "unknown argument $key in constructing " . $class->tag_uri .  "type",
    );
  }

  my $self = { };

  if ($arg->{referent}) {
    my $ref_checker = $rx->make_schema($arg->{referent});

    $self->{referent} = $ref_checker;
  }

  return bless $self => $class;
}

sub check {
  my ($self, $value) = @_;

  local $@;

  return unless ref $value and (ref $value eq 'REF' or ref $value eq 'SCALAR');
  return 1 unless $self->{referent};
  return $self->{referent}->check($$value);
}

1;

__END__
=pod

=head1 NAME

Data::Rx::Type::Perl::Ref - experimental / perl reference type

=head1 VERSION

version 0.004

=head1 SYNOPSIS

  use Data::Rx;
  use Data::Rx::Type::Perl::Ref;
  use Test::More tests => 2;

  my $rx = Data::Rx->new({
    prefix  => {
      perl => 'tag:codesimply.com,2008:rx/perl/',
    },
    type_plugins => [ 'Data::Rx::Type::Perl::Ref' ]
  });

  my $int_ref_rx = $rx->make_schema({
    type       => '/perl/ref',
    referent   => '//int',
  });

  ok(  $int_ref_rx->check(  1 ), "1 is not a ref to an integer");
  ok(! $int_ref_rx->check( \1 ), "\1 is a ref to an integer");

=head1 ARGUMENTS

"referent" indicates another type to which the reference must refer.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

