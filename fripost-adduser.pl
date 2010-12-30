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

use FindBin qw($Bin);
use lib "$Bin/lib";

use Data::Dumper;
use DateTime;
use Email::Valid;
use Fripost::Password;
use Fripost::Schema;
use IO::Prompt;
use Getopt::Long;
use String::MkPasswd qw/mkpasswd/;
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

say "Adding a new virtual user.";

# Get the full e-mail of the user (aka e-mail)
while (not defined $user{username}) {
    $user{username} = prompt "New username: ";
    if (!Email::Valid->address($user{username})) {
        undef $user{username};
        say "This is not a valid e-mail address. Try again."
    }
}

# Full name of user
$user{name} = prompt "Full (real) name: ";

# Extrapolate domain from full e-mail
my @parts = split /\@/, $user{username};
my $username = $parts[0];
my $domain   = $parts[1];

# Set domain name
$user{domain} = $domain;

# Construct maildir from domain and user
$user{maildir} = "$domain/$username/Maildir";

# Set dates
my $now = DateTime->now();
$user{create_date} = $now;
$user{change_date} = $now;

$user{active} = 1;

# Generate password
my $password = mkpasswd(
    -length => 20,
    -minnum => 5,
    -minspecial => 3
);
$user{password} = smd5($password);

# Show the information that will be inserted
say Dumper \%user;
say "Generated password: ";
say $password;

# Make the insert after a prompt
my $ok = prompt "Is this OK? ", -yn;

if (!$ok) {
    say "Aborted by user."
} else {
    my $user = $schema->resultset('Mailbox')->new(\%user);
    $user->insert;
    say "New account added."
}

=head1 AUTHOR

Stefan Kangas C<< <skangas at skangas.se> >>

=head1 COPYRIGHT

Copyright 2010 Stefan Kangas.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it
under the same terms as perl itself.

=cut
