# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Abstract K8s complexities with HyScale’s app-centric approach & automate enterprise-wide deployments to multi cloud"
HOMEPAGE="https://www.hyscale.io"
SRC_URI="https://github.com/hyscale/${PN}/releases/download/v${PV}/${PN}-${PV}-linux -> ${PN}-${PV}"
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

