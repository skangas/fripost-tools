package Fripost::Schema::Result::Mailbox;

use 5.010_000;
use warnings;
use strict;

use base qw/DBIx::Class::Core/;

# mysql> describe mailbox;
# +-------------+--------------+------+-----+---------------------+-------+
# | Field       | Type         | Null | Key | Default             | Extra |
# +-------------+--------------+------+-----+---------------------+-------+
# | username    | varchar(255) | NO   | PRI |                     |       | 
# | password    | varchar(255) | NO   |     |                     |       | 
# | name        | varchar(255) | NO   |     |                     |       | 
# | maildir     | varchar(255) | NO   |     |                     |       | 
# | domain      | varchar(255) | NO   |     |                     |       | 
# | create_date | datetime     | NO   |     | 0000-00-00 00:00:00 |       | 
# | change_date | datetime     | NO   |     | 0000-00-00 00:00:00 |       | 
# | active      | tinyint(4)   | NO   |     | 1                   |       | 
# +-------------+--------------+------+-----+---------------------+-------+
# 8 rows in set (0.00 sec)

__PACKAGE__->load_components(qw/InflateColumn::DateTime/);

__PACKAGE__->table('mailbox');
__PACKAGE__->add_columns(qw/ username password name maildir domain active /);
__PACKAGE__->add_columns(
    create_date => { data_type => 'datetime', timezone => "Europe/Stockholm", locale => 'sv_SE' },
    change_date => { data_type => 'datetime', timezone => "Europe/Stockholm", locale => 'sv_SE' }
);

__PACKAGE__->set_primary_key('username');

=head1 NAME

Fripost::Schema::Result::Mailbox - 

=head1 AUTHOR

Stefan Kangas C<< <skangas at skangas.se> >>

=head1 COPYRIGHT

Copyright 2010 Stefan Kangas, all rights reserved.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it
under the same terms as perl itself.

=cut

1; # End of Mailbox.pm
