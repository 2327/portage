# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Pritunl-client-electron is an open source openvpn client. Documentation and more information can be found at the home page client.pritunl.com"
HOMEPAGE="https://client.pritunl.com"
SRC_URI="https://github.com/pritunl/pritunl-client-electron/archive/${PV}.tar.gz -> pritunl-client-electron-${PV}.tar.gz"

inherit eutils

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
    unpack pritunl-client-electron-${PV}.tar.gz
	mv ${WORKDIR}/pritunl-client-electron-${PV} ${S}

    pushd ${S}/client
	npm install || die
}

src_compile() {
    pushd client
    ./node_modules/.bin/electron-rebuild  || die
    ./node_modules/.bin/electron-packager ./ Pritunl --platform=linux --arch=x64 --icon=./www/img/pritunl.icns --out=../build/linux/  || die
    
}

src_install() {
    insinto /opt
    doins -r "${S}/build/linux/Pritunl-linux-x64"
    fperms 0775 \
        /opt/Pritunl-linux-x64/Pritunl \
        /opt/Pritunl-linux-x64/libEGL.so \
        /opt/Pritunl-linux-x64/libffmpeg.so \
        /opt/Pritunl-linux-x64/libGLESv2.so \
        /opt/Pritunl-linux-x64/chrome-sandbox \
        /opt/Pritunl-linux-x64/swiftshader/libGLESv2.so \
        /opt/Pritunl-linux-x64/swiftshader/libEGL.so
    
    dosym "/opt/Pritunl-linux-x64/Pritunl" /opt/bin/Pritunl
}

