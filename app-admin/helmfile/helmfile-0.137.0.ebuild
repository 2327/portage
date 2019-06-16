# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Deploy Kubernetes Helm Charts"
HOMEPAGE="https://github.com/roboll/helmfile/"
SRC_URI="https://github.com/roboll/${PN}/releases/download/v${PV}/${PN}_linux_amd64 -> ${PN}-${PV}"
S="${DISTDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DOCS=( README.md )

src_unpack() { 
  true
}

src_install() {
  dobin ${PN}-${PV}
  dosym ${PN}-${PV} /usr/bin/${PN}

}

