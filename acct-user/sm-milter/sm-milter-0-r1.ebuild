# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="A user for sendmail milters"

ACCT_USER_ID="106"
ACCT_USER_GROUPS=( "milter" )
ACCT_USER_HOME="/var/lib/milter"

acct-user_add_deps
