TERMUX_PKG_HOMEPAGE="https://fennel-lang.org"
TERMUX_PKG_DESCRIPTION="A Lisp that compiles to Lua"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.5.1
TERMUX_PKG_SRCURL="https://github.com/bakpakin/Fennel/archive/refs/tags/$TERMUX_PKG_VERSION.tar.gz"
TERMUX_PKG_SHA256=7456737a2e0fc17717ea2d80083cfcf04524abaa69b1eb79bded86b257398cd0
TERMUX_PKG_DEPENDS="lua54|lua53|lua52|luajit|lua51"
TERMUX_PKG_BUILD_DEPENDS="lua54|lua53|lua52|luajit|lua51"
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_BUILD_IN_SRC=true

iscmd() {
	command -v "$1" >/dev/null
}

termux_step_pre_configure() {
	local luabin luadeps luadep
	IFS=\| read -r -a luadeps <<< "$TERMUX_PKG_BUILD_DEPENDS"
	for luadep in "${luadeps[@]}"; do
		luabin=$(sed 's/lua5([1-4])/lua5.\1/' <<< "$luadep")
		case "$luadep" in
			lua5*)
				luabin="lua5.${luadep#lua5}"
				;;
			*)
				luabin="$luadep"
				;;
		esac
		if command -v "$LUA" >/dev/null; then
			export LUA="$luabin"; break
		else
			continue
		fi

	done
}
