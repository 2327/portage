# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Deploy Kubernetes Helm Charts"
HOMEPAGE="https://github.com/helmfile/helmfile/"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/v${PV}/${PN}_${PV}_linux_amd64.tar.gz -> ${PN}-${PV}.tar.gz"
S="${WORKDIR}"

LICENSE="MIT License"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DOCS=( README.md )

src_install() {
  newbin ${PN} ${PN}-${PV}
  dosym ${PN}-${PV} /usr/bin/${PN}
}

