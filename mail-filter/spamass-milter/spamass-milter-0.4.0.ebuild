# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="8"

IUSE=""

DESCRIPTION="A milter for SpamAssassin"
HOMEPAGE="https://savannah.nongnu.org/projects/spamass-milt/"
SRC_URI="http://download.savannah.nongnu.org/releases/spamass-milt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"

DEPEND="|| ( mail-filter/libmilter mail-mta/sendmail )
        >=mail-filter/spamassassin-3.1.0"

CDEPEND="
    acct-group/sm-milter
    acct-user/sm-milter
"

RDEPEND="${DEPEND}"

src_install() {
        emake DESTDIR="${D}" install

        newinitd "${FILESDIR}"/spamass-milter.rc4 spamass-milter
        newconfd "${FILESDIR}"/spamass-milter.conf3 spamass-milter
        dodir /var/lib/milter
        keepdir /var/lib/milter
        fowners milter:milter /var/lib/milter

        dodoc AUTHORS NEWS README ChangeLog "${FILESDIR}/README.gentoo"
}

