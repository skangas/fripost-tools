#!/usr/bin/perl

use 5.010_000;
use warnings;
use strict;

=head1 NAME

fripost-mkpass.pl - Create a random new password

=cut

our $VERSION = '0.01';

use Fripost::Password;
use String::MkPasswd qw/mkpasswd/;

# Generate password
my $password = mkpasswd(
    -length => 20,
    -minnum => 5,
    -minspecial => 3
);
$user{password} = smd5($password);

# Show the information that will be inserted
say "Generated password: $password";
say "Salted MD5: " . smd5($password);

=head1 AUTHOR

Stefan Kangas C<< <skangas at skangas.se> >>

=head1 COPYRIGHT

Copyright 2010 Stefan Kangas.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it
under the same terms as perl itself.

=cut
