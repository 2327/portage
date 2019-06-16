# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_SRC="github.com/jjneely"
EGO_PN="${EGO_SRC}/${PN}"

DESCRIPTION="Alertmanager Event Handler"
HOMEPAGE="https://github.com/jjneely/am-event-handler"
#EGIT_REPO_URI="https://github.com/jjneely/am-event-handler"
#EGIT_COMMIT="${PV}"
SRC_URI="https://${EGO_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples pie systemd"

DOCS=( README.md )

DEPEND="dev-lang/go !app-metrics/${PN}"
RDEPEND="${DEPEND}"
BDEPEND=""

inherit golang-vcs-snapshot golang-build systemd user

pkg_setup() {
    ebegin "Create user and group"
    enewgroup am-event-handler
    enewuser am-event-handler -1 -1 -1 am-event-handler
}

src_compile() {
    ebegin "Compiling"

    export GOPATH="${S}"
    ln -s ${GOPATH}/src/${EGO_PN} ${GOPATH}/src/${P}

	local mygoargs=(
		-v -work -x
		"-buildmode=$(usex pie pie default)"
		-asmflags "-trimpath=${WORKDIR}/${P}/src/${EGO_PN}"
		-gcflags "-trimpath=${WORKDIR}/${P}/src/${EGO_PN}"
		-ldflags "-s -w"
		-tags "$(usex !systemd 'nosystemd' '')"
	)

    go build "${mygoargs[@]}" ${P} || die
}

src_test() {
	go test -v -short -race ./... || die
}

src_install() {
	dobin ${PN}

	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
    if use examples; then
        systemd_dounit "${FILESDIR}/${PN}.service"
    fi

	insinto /etc/am-event-handler
	newins ${WORKDIR}/${P}/src/${EGO_PN}/testdata/config.yaml am-event-handler.yml.example

    if use examples; then
        insinto /usr/share/doc/${P}/examples
        newins "${WORKDIR}/${P}/src/${EGO_PN}/testdata/*" \
            || die 'copy examples failed'
    fi

    diropts -o am-event-handler -g am-event-handler -m 0750
    keepdir /var/log/am-event-handler
}
