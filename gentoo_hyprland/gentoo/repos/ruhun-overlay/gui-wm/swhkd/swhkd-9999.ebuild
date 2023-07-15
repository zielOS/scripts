# Copyright 2023 Ahsanur Rahman <ahsanaur041@gmail.com>
# Distributred under the terms of the ISC License

EAPI=8
inherit cargo git-r3

DESCRIPTION="A next-generation hotkey daemon for Wayland/X11 written in Rust"
HOMEPAGE="https://github.com/waycrate/swhkd"

LICENSE="BSD-2-Clause"
SLOT="0"
KEYWORDS="~amd64"

EGIT_REPO_URI="https://github.com/waycrate/swhkd"

src_compile() {
	if [[ -f Makefile ]] || [[ -f GNUmakefile ]] || [[ -f makefile ]]; then
		emake || die "emake failed"
	fi
}

src_install() {
	if [[ -f Makefile ]] || [[ -f GNUmakefile ]] || [[ -f makefile ]] ; then
		emake DESTDIR="${D}" install
	fi
}

