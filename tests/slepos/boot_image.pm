# SUSE's openQA tests
#
# Copyright © 2016 SUSE LLC
#
# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.

# G-Summary: Basic SLEPOS test
# G-Maintainer: Vladimir Nadvornik <nadvornik@suse.cz>

use base "basetest";
use strict;
use warnings;
use testapi;
use utils;


sub run() {
    my $self = shift;

    unless (get_var("SLEPOS") =~ /^terminal-offline/) {
        mutex_lock("bs1_images_synced");
        mutex_unlock("bs1_images_synced");
        resume_vm();
    }

    my $select_id = get_var("SLEPOS_SELECT_ID");
    if (defined $select_id) {
        assert_screen("slepos-select-id", 200);
        while (--$select_id > 0) {
            send_key "down";
        }
        send_key("ret");
    }

    my $select_role = get_var("SLEPOS_SELECT_ROLE");
    if (defined $select_role) {
        assert_screen("slepos-select-role", 200);
        while (--$select_role > 0) {
            send_key "down";
        }
        send_key("ret");
    }

    assert_screen("slepos-image-login", 300);

    type_string $username;
    send_key "ret";
    assert_screen "displaymanager-password-prompt";
    type_string $password;
    send_key "ret";
}

sub test_flags() {
    return {fatal => 1, milestone => 1};
}

1;
# vim: set sw=4 et:
