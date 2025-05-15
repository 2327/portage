# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="user for glauth"
ACCT_USER_ID=636
ACCT_USER_GROUPS=( glauth )

acct-user_add_deps

