#!/usr/bin/perl

use 5.010_000;
use warnings;
use strict;

=head1 NAME

Prompt.pm - Lots of prompt helper functions

=cut

our $VERSION = '0.01';

use Data::Dumper;
use Email::Valid;
use Exporter;
use IO::Prompt;
use String::MkPasswd qw/mkpasswd/;

our @EXPORT = qw(prompt_password prompt_username);

sub prompt_password {
    my $prompt = shift;
    $prompt //= "Enter new password (blank for random): ";
    my $password = prompt $prompt;
    if (!length $password) {
        $password = mkpasswd(
            -length => 10,
            -minnum => 2,
            -minspecial => 2,
        );
        say "Generated password: $password";    
    }
    return $password;
}

sub prompt_username {
    my $prompt = shift;
    $prompt //= "Enter username: ";
    my $username;
    while (not defined $username) {
        $username = prompt $prompt;
        if (!($username =~ /\@/)) {
            $username .= '@fripost.org';
            say "Using $username";
        }
        if (!Email::Valid->address($username)) {
            undef $username;
            say "This is not a valid e-mail address. Try again."
        }
    }
    return $username;
}

=head1 AUTHOR

Stefan Kangas C<< <skangas at skangas.se> >>

=head1 COPYRIGHT

Copyright 2010 Stefan Kangas.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it
under the same terms as perl itself.

=cut

1; # End of Prompt.pm
