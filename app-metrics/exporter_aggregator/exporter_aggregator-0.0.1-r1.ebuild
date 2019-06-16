# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_SRC="github.com/tynany"
EGO_PN="${EGO_SRC}/${PN}"

DESCRIPTION="Exporter Aggregator will scape metrics from a list of Prometheus exporter endpoints and aggregate the values of any metrics with the same name and label/s."
HOMEPAGE="https://github.com/tynany/exporter_aggregator"

if [[ ${PV} == "9999" ]] ; then
    EGIT_REPO_URI="https://github.com/tynany/${PN}.git"
    EGIT_COMMIT="${PV}"
    SRC_URI=""
    inherit git-r3 distutils-r1 golang-vcs-snapshot golang-build systemd user
else
    SRC_URI="https://${EGO_PN}/releases/download/v${PV}/exporter_aggregator_${PV}_linux_x86_64.tar.gz -> ${P}.tar.gz"
    inherit golang-vcs-snapshot golang-build systemd user
fi

RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples pie systemd"

DOCS=( README.md )

DEPEND="dev-lang/go !app-metrics/${PN}"
RDEPEND="${DEPEND}"
BDEPEND=""

pkg_setup() {
    ebegin "Create user and group"
    enewgroup exporter_aggregator
    enewuser exporter_aggregator -1 -1 -1 am-event-handler
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

#	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
#	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
    if use examples; then
        systemd_dounit "${FILESDIR}/${PN}.service"
    fi

	insinto /etc/exporter_aggregator
	newins ${WORKDIR}/${P}/src/${EGO_PN}/config_example.yaml exporter_aggregator.yml.example

    if use examples; then
        insinto /usr/share/doc/${P}/examples
        newins "${WORKDIR}/${P}/src/${EGO_PN}/config_example.yaml" \
            || die 'copy examples failed'
    fi

    diropts -o exporter_aggregator -g exporter_aggregator -m 0750
    keepdir /var/log/exporter_aggregator
}
