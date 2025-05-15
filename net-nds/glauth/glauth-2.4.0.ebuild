# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

DESCRIPTION="GLAuth: LDAP authentication server for developers"
HOMEPAGE="https://github.com/glauth/glauth"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/v${PV}/${PN}-linux-amd64 -> ${P}"
S="${DISTDIR}"

LICENSE="MIT License"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="acct-group/${PN} acct-user/${PN}"
RDEPEND="${DEPEND}"
BDEPEND=""

RESTRICT="mirror strip"

#src_unpack() {
#  true
#}

src_install() {
    dodir /etc/${PN}
	keepdir /etc/${PN}
    dodir /var/log/${PN}
	keepdir /var/log/${PN}
    dobin ${P}
	dosym /usr/bin/${P} /usr/bin/${PN}
    newinitd ${FILESDIR}/${PN}.initd ${PN}
    newconfd ${FILESDIR}/${PN}.confd ${PN}
    insinto /etc/${PN}
    newins ${FILESDIR}/${PN}.conf ${PN}.conf
    doins ${FILESDIR}/${PN}.conf
    fowners ${PN}:${PN} /etc/${PN}
    fowners ${PN}:${PN} /var/log/${PN}
}

#pkg_postinst() {
#    if [[ -x /etc/init.d/your_init_script ]]; then
#        rc-update add ${PN} default
#    fi
#}

#pkg_postrm() {
#    if [[ -x /etc/init.d/your_init_script ]]; then
#        rc-update del ${PN} default
#    fi
#}


#DOCS=( README.md )

#src_install() {
#  dobin ${PN}-${PV}
#  dosym ${PN}-${PV} /usr/bin/${PN}
#
#}

