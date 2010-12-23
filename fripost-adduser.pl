#!/usr/bin/perl

use 5.010_000;
use warnings;
use strict;

=head1 NAME

fripost-adduser.pl - Add a new mailbox to the system

=head1 DESCRIPTION

This script eases the burden of adding a new user to the system.

Necessary steps to add a user to the system:
1. Create the Maildir (ensuring proper permissions)
2. Add him to the MySQL database
3. Send welcome message
4. Ensure welcome message has arrived

=cut

our $VERSION = '0.01';

use Data::Dumper;
use DateTime;
use Email::Valid;
use Fripost::Schema;
use IO::Prompt;
use Getopt::Long;
use YAML::Syck;

## Get command line options
our $conf = LoadFile('default.yml');

GetOptions(
    'dbi_dsn'    => \$conf->{dbi_dsn},
    'admuser=s' => \$conf->{admuser},
    'admpass=s' => \$conf->{admpass},
) or die "Unable to get command line options.";

# Connect to the database
my $schema = Fripost::Schema->connect(
    $conf->{dbi_dsn}, $conf->{admuser}, $conf->{admpass}, {} #\%dbi_params
);

my %user;

# Get the full e-mail of the user (aka e-mail)
while (not defined $user{username}) {
    $user{username} = prompt "Enter the full e-mail: ";
    if (!Email::Valid->address($user{username})) {
        undef $user{username};
        say "This is not a vaild e-mail address. Try again."
    }
}

# Full name of user
$user{name} = prompt "Full (real) name: ";

# Extrapolate domain from full e-mail
my @parts = split /\@/, $user{username};
my $username = $parts[0];
my $domain   = $parts[1];

print "Username: $username\nDomain:$domain\n";

die;

# Set domain name
$user{domain} = $domain;

# Construct maildir from domain and user
$user{maildir} = "$domain/$username/Maildir";

# Set dates
my $now = DateTime->now();
$user{create_date} = $now;
$user{change_date} = $now;

$user{active} = 1;

my $user = $schema->resultset('Mailbox')->new(\%user);

# Make the insert into database
$user->insert;

=head1 AUTHOR

Stefan Kangas C<< <skangas at skangas.se> >>

=head1 COPYRIGHT

Copyright 2010 Stefan Kangas, all rights reserved.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it
under the same terms as perl itself.

=cut
