# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="k0s is an all-inclusive Kubernetes distribution with all the required bells and whistles preconfigured to make building a Kubernetes clusters a matter of just copying an executable to every host and running it."
HOMEPAGE="https://github.com/k0sproject/k0s"
SRC_URI="https://github.com/k0sproject/${PN}/releases/download/v${PV}/${PN}-v${PV}-amd64 -> ${PN}-${PV}"
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

