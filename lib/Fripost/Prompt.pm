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

sub confirm_or_abort {
    my ($msg) = @_;
    $msg //= "Is this OK? [no will abort] ";
    my $confirmed = prompt $msg, -ynt;
    unless ($confirmed) {
        say "User aborted";
        exit 1;
    }
}

sub fix_username {
    my ($nam) = @_;
    if ($nam !~ /\@/) {
        $nam .= '@fripost.org';
        say "Using username: $nam";
    }
    return $nam;
}

sub prompt_email {
    my ($msg, $is_username) = @_;
    $msg //= "Enter email: ";
    my $email;
    while (not defined $email) {
        $email = prompt $msg;

        if ($is_username) {
            $email = fix_username($email)
        }

        if (!Email::Valid->address($email)) {
            undef $email;
            say "This is not a valid e-mail address. Try again."
        }
    }
    return $email;
    
}

sub prompt_password {
    my ($msg, $msg2) = @_;
    $msg  //= "Enter new password (blank for random): ";
    $msg2 //= "Enter new password again (blank for random): ";

    my $password;
    while (not defined $password) {
        $password   = prompt $msg,  -e => '*';
        my $confirm = prompt $msg2, -e => '*';
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
        say "Using password: $password";    
    }
    return smd5($password);
}

=head1 AUTHOR

Stefan Kangas C<< <skangas at skangas.se> >>

=head1 COPYRIGHT

Copyright 2010,2011 Stefan Kangas.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it
under the same terms as perl itself.

=cut

1; # End of Prompt.pm
