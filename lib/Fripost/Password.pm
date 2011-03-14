package Fripost::Password;

use 5.010_000;
use strict;

=head1 NAME

Password.pm - Generate passwords

=cut

our $VERSION = '0.01';

use Data::Dumper;
use Digest::MD5;
use Exporter;
use MIME::Base64;

our @EXPORT = qw/smd5 make_salt/;
our @ISA = qw(Exporter);

sub smd5 {
    my $pw = shift;
    my $salt = shift || &make_salt();
    return "{SMD5}" . pad_base64( MIME::Base64::encode( Digest::MD5::md5( $pw . $salt ) . $salt, '' ) );
}

sub make_salt {
    my $len   = 8 + int( rand(8) );
    my @bytes = ();
    for my $i ( 1 .. $len ) {
        push( @bytes, rand(255) );
    }
    return pack( 'C*', @bytes );
}

sub pad_base64 {
    my $b64_digest = shift;
    while ( length($b64_digest) % 4 ) {
        $b64_digest .= '=';
    }
    return $b64_digest;
}

=head1 AUTHOR

Stefan Kangas C<< <skangas at skangas.se> >>

=head1 BUGS

Please report any bugs to C<< <skangas at skangas.se> >>

=head1 COPYRIGHT

Copyright (c) 2010 Dominik Schulz (dominik.schulz@gauner.org). All rights reserved.

Copyright 2010,2011 Stefan Kangas, all rights reserved.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

=cut

1; # End of Password.pm

__END__

