# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DESCRIPTION="kind is a tool for running local Kubernetes clusters using Docker container"
HOMEPAGE="kind.sigs.k8s.io/"
SRC_URI="https://github.com/kubernetes-sigs/${PN}/releases/download/v${PV}/${PN}-linux-amd64 -> ${PN}-${PV}"
S="${DISTDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DOCS=( README.md )

BDEPEND="app-emulation/docker"

src_unpack() { 
  true
}

src_install() {
  dobin ${PN}-${PV}
  dosym ${PN}-${PV} /usr/bin/${PN}

}

