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

sub fix_username {
    my ($nam) = @_;
    if ($nam !~ /\@/) {
        $nam .= '@fripost.org';
        say "Using $nam";
    }
    return $nam;
}

sub prompt_password {
    my ($prompt, $prompt2) = @_;
    $prompt //= "Enter new password (blank for random): ";
    $prompt2 //= "Enter new password again (blank for random): ";

    my $password;
    while (not defined $password) {
        $password = prompt $prompt, -e => '*';
        my $confirm = prompt $prompt2, -e => '*';
        unless ($password eq $confirm) {
            undef $password;
            say "Passwords do not match";
        }
    }

    if (!length $password) {
        $password = mkpasswd(
            -length => 10,
            -minnum => 2,
            -minspecial => 2,
        );
        say "Generated password: $password";    
    }
    return smd5($password);
}

sub prompt_username {
    my $prompt = shift;
    $prompt //= "Enter username: ";
    my $nam;
    while (not defined $nam) {
        $nam = prompt $prompt;
        $nam = fix_username($nam);
        if (!Email::Valid->address($nam)) {
            undef $nam;
            say "This is not a valid e-mail address. Try again."
        }
    }
    return $nam;
}

sub ask_if_ok_or_abort {
    my $confirmed = prompt "Is this OK? [no will abort]", -ynt;
    unless ($confirmed) {
        say "User aborted";
        exit 1;
    }
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
