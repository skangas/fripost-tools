package Fripost::Schema::Result::Log;

use 5.010_000;
use warnings;
use strict;

use base qw/DBIx::Class::Core/;

# mysql> describe log;
# +-------+-------------+------+-----+-------------------+----------------+
# | Field | Type        | Null | Key | Default           | Extra          |
# +-------+-------------+------+-----+-------------------+----------------+
# | id    | int(11)     | NO   | PRI | NULL              | auto_increment | 
# | user  | varchar(20) | NO   |     |                   |                | 
# | event | text        | NO   |     | NULL              |                | 
# | date  | timestamp   | NO   |     | CURRENT_TIMESTAMP |                | 
# +-------+-------------+------+-----+-------------------+----------------+
# 4 rows in set (0.00 sec)

__PACKAGE__->load_components(qw/InflateColumn::DateTime/);

__PACKAGE__->table('mailbox');
__PACKAGE__->add_columns(qw/ id user event /);
__PACKAGE__->add_columns(
    date => { data_type => 'datetime', timezone => "Europe/Stockholm", locale => "se_SV" },
);
  
__PACKAGE__->set_primary_key('id');

=head1 NAME

Fripost::Schema::Result::Log - 

=head1 AUTHOR

Stefan Kangas C<< <skangas at skangas.se> >>

=head1 COPYRIGHT

Copyright 2010,2011 Stefan Kangas, all rights reserved.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it
under the same terms as perl itself.

=cut

1; # End of Log.pm
