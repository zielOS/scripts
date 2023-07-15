# Copyright 2023 Ahsanur Rahman <knotteye@waldn.net>
# Distributed under the terms of the ISC License

EAPI=8

DESCRIPTION="GTK3-based menu for wlroots compositors"
HOMEPAGE="https://github.com/nwg-piotr/nwg-menu/"

inherit go-module xdg-utils desktop

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nwg-piotr/nwg-menu.git"
  KEYWORDS="~amd64"
else
	SRC_URI="https://github.com/nwg-piotr/nwg-menu/archive/refs/tags/v${PV}.tar.gz -> ${P}-src.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

DEPEND="
  gui-libs/gtk-layer-shell	
"
RDEPEND="${DEPEND}"

src_compile() {
  ego get
  ego build
}

src_install() {
	dobin nwg-menu
	insinto /usr/share/nwg-menu
	doins -r langs
	doins stuff/main.glade
	insinto /usr/share/pixmaps
	doins stuff/nwg-menu.svg
	domenu stuff/nwg-menu.desktop
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
