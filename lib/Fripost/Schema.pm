package Fripost::Schema;

use 5.010_000;
use warnings;
use strict;

use base qw/DBIx::Class::Schema/;
our $VERSION = '0.01';

  __PACKAGE__->load_namespaces();

1;

=head1 NAME

Fripost::Schema - 

=head1 AUTHOR

Stefan Kangas C<< <skangas at skangas.se> >>

=head1 COPYRIGHT

Copyright 2010,2011 Stefan Kangas, all rights reserved.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it
under the same terms as perl itself.

=cut

1; # End of Schema.pm

__END__

