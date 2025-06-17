#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

cd "$(dirname "$0")"

main() {
	root_path=$(realpath ../packages/)
	cd $root_path

	packages=$(find . -mindepth 1 -maxdepth 1 -type d)
	gitignore_path=$(find .. -mindepth 1 -maxdepth 1 -type f -name '.gitignore' | xargs realpath)

	for pkg in $packages
	do
		echo "pkg: $pkg"
		tar --create --xz --verbose --exclude-vcs-ignores --exclude="vendor" --exclude="web" --exclude="composer.lock" --file "$pkg.tar.xz" $pkg
	done
}

main "$@"
