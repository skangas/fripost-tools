package Fripost::Schema::Result::Domain;

use 5.010_000;
use warnings;
use strict;

use base qw/DBIx::Class::Core/;

# mysql> describe domain;
# +-------------+--------------+------+-----+---------------------+-------+
# | Field       | Type         | Null | Key | Default             | Extra |
# +-------------+--------------+------+-----+---------------------+-------+
# | domain      | varchar(255) | NO   | PRI |                     |       | 
# | description | varchar(255) | NO   |     |                     |       | 
# | create_date | datetime     | NO   |     | 0000-00-00 00:00:00 |       | 
# | change_date | timestamp    | NO   |     | CURRENT_TIMESTAMP   |       | 
# | active      | tinyint(4)   | NO   |     | 1                   |       | 
# +-------------+--------------+------+-----+---------------------+-------+
# 5 rows in set (0.00 sec)

__PACKAGE__->load_components(qw/InflateColumn::DateTime/);

__PACKAGE__->table('domain');
__PACKAGE__->add_columns(qw/ domain description create_date change_date active /);
__PACKAGE__->add_columns(
    create_date => { data_type => 'datetime', timezone => "Europe/Stockholm", locale => "se_SV" },
    change_date => { data_type => 'datetime', timezone => "Europe/Stockholm", locale => "se_SV" },
);
  
__PACKAGE__->set_primary_key('domain');

=head1 NAME

Fripost::Schema::Result::Domain - 

=head1 AUTHOR

Stefan Kangas C<< <skangas at skangas.se> >>

=head1 COPYRIGHT

Copyright 2010, 2011 Stefan Kangas, all rights reserved.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it
under the same terms as perl itself.

=cut

1; # End of Domain.pm
