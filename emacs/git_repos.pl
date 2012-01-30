#!perl
use strict;
use warnings;
use autodie;

use Cwd ();
use File::Spec ();

BEGIN {
    no warnings 'redefine';
    my $orig_code = \&CORE::GLOBAL::system;
    if (!$ENV{RUN}) {
        *CORE::GLOBAL::system = sub {
            my $cwd = Cwd::getcwd;
            print "@_", ' ', "in $cwd", "\n";
        };
    }
};

my %module_repos = (
    wanderlust => {
        url => 'https://github.com/wanderlust/wanderlust.git',
        after_hook => sub {
            system("make");
            system("sudo make install");
        },
    },

    magit => {
        url => 'https://github.com/magit/magit.git',
        after_hook => sub {
            system("make");
        },
    },

    'org-mode'=> {
        url => 'git://orgmode.org/org-mode.git',
        after_hook => sub {
            system("make");
        },
    },

    'twittering-mode' => {
        url => 'https://github.com/hayamiz/twittering-mode.git',
        after_hook => sub {
            system("make");
        },
    },

    'slime' => {
        url => 'git://github.com/nablaone/slime.git',
    },
    'auto-complete' => {
        url => 'https://github.com/m2ym/auto-complete.git',
        after_hook => sub {
            system("make");
        },
    },

    'io-mode' => {
        url => 'https://github.com/superbobry/io-mode.git',
    },

    'io-emacs' => {
        url => 'https://github.com/slackorama/io-emacs.git',
    },
);

my $EMACS_DIR = File::Spec->catfile($ENV{HOME}, ".emacs.d", "repos");

chdir $EMACS_DIR;
while (my ($module, $conf) = each %module_repos) {
    my $is_cloned_now = 0;

    if ( -d $module ) {
        chdir $module;

        my ($repo, $branch) = ($conf->{repository}, $conf->{branch});
        $repo   ||= 'origin';
        $branch ||= 'master';

        my @pull = ("git", "pull", $repo, $branch);
        system @pull;
    } else {
        my @clone = ("git", "clone", $conf->{url});
        system @clone;

        chdir $module;
    }

    if ($conf->{after_hook}) {
        unless (ref $conf->{after_hook} eq "CODE") {
            die "'after_hook' paramter should be CodeRef";
        }

        $conf->{after_hook}->($module);
    }

    chdir File::Spec->updir;
}
