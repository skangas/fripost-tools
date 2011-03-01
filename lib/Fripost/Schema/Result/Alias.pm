package Fripost::Schema::Result::Alias;

use 5.010_000;
use warnings;
use strict;

use base qw/DBIx::Class::Core/;

# mysql> describe alias;
# +-------------+--------------+------+-----+---------------------+-------+
# | Field       | Type         | Null | Key | Default             | Extra |
# +-------------+--------------+------+-----+---------------------+-------+
# | address     | varchar(255) | NO   | PRI |                     |       | 
# | goto        | text         | NO   |     | NULL                |       | 
# | domain      | varchar(255) | NO   |     |                     |       | 
# | create_date | datetime     | NO   |     | 0000-00-00 00:00:00 |       | 
# | change_date | timestamp    | NO   |     | CURRENT_TIMESTAMP   |       | 
# | active      | tinyint(4)   | NO   |     | 1                   |       | 
# +-------------+--------------+------+-----+---------------------+-------+
# 6 rows in set (0.00 sec)

__PACKAGE__->load_components(qw/InflateColumn::DateTime/);

__PACKAGE__->table('alias');
__PACKAGE__->add_columns(qw/ address goto domain create_date change_date active /);
__PACKAGE__->add_columns(
    create_date => { data_type => 'datetime', timezone => "Europe/Stockholm", locale => "se_SV" },
    change_date => { data_type => 'datetime', timezone => "Europe/Stockholm", locale => "se_SV" },
);
  
__PACKAGE__->set_primary_key('address');

=head1 NAME

Fripost::Schema::Result::Alias - 

=head1 AUTHOR

Stefan Kangas C<< <skangas at skangas.se> >>

=head1 COPYRIGHT

Copyright 2010,2011 Stefan Kangas, all rights reserved.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it
under the same terms as perl itself.

=cut

1; # End of Alias.pm
