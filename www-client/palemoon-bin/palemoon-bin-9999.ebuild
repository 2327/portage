# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PM_HTTP_URI="http://linux.palemoon.org/datastore/release"
DESCRIPTION="Pale Moon is an Open Source, Goanna-based web browser available for Microsoft Windows and Linux (with other operating systems in development), focusing on efficiency and customization. Make sure to get the most out of your browser!"
HOMEPAGE="https://www.palemoon.org/"

SRC_URI="${SRC_URI} ${PM_HTTP_URI}/palemoon-unstable-latest.linux-x86_64-gtk2.tar.xz -> ${P}.tar.xz" 

BIN_PN="${PN/-bin/}"

LICENSE="MPL-2.0 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=sys-apps/dbus-1.10.18
	>=dev-libs/dbus-glib-0.110
	"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${BIN_PN}"

src_unpack() {
    unpack ${A}
}

src_install() {
    declare PALEMOON_INSTDIR=/opt/${BIN_PN}

	local size sizes icon_path icon name
	sizes="16 32 48"
	icon_path="${S}/browser/chrome/icons/default"
	icon="${PN}"
	name="Pale Moon"

	# Install icons and .desktop for menu entry:
	for size in ${sizes}; do
		insinto "/usr/share/icons/hicolor/${size}x${size}/apps"
		newins "${icon_path}/default${size}.png" "${icon}.png" || die
	done

    # The 128x128 icon has a different name
    insinto /usr/share/icons/hicolor/128x128/apps
    newins "${icon_path}/../../../icons/mozicon128.png" "${icon}.png" || die
    # Install a 48x48 icon into /usr/share/pixmaps for legacy DEs
    ##newicon "${S}"/browser/chrome/icons/default/default48.png ${PN}.png

    insinto /usr/share/applications/
	doins "${FILESDIR}"/${PN}.desktop

	dodir ${PALEMOON_INSTDIR%/*}
	mv "${S}" "${ED}"${PALEMOON_INSTDIR} || die

    dosym "${PALEMOON_INSTDIR}/palemoon-bin" /usr/bin/palemoon-bin

    insinto /usr/share/gnome-control-center/default-apps
    doins "${FILESDIR}"/palemoon-browser.xml

	insinto /etc/revdep-rebuild
	echo "SEARCH_DIRS_MASK=${PALEMOON_INSTDIR}" >> ${T}/10${PN}
	doins "${T}"/10${PN} || die
}
