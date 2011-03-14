package Fripost::Logger;

use 5.010_000;
use strict;

=head1 NAME

Logger.pm - 

=cut

our $VERSION = '0.01';

use Moose;
use namespace::autoclean;

sub log_adduser {
    
}

no Moose;
__PACKAGE__->meta->make_immutable;

=head1 AUTHOR

Stefan Kangas C<< <skangas at skangas.se> >>

=head1 COPYRIGHT

Copyright 2010,2011 Stefan Kangas.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it
under the same terms as perl itself.

=cut

1; # End of Logger.pm

