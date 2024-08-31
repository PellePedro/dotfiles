#!/bin/bash

set -x
GO_VERSION="1.23.0"
# GO_VERSION="1.22.6"
GOPLS_VERSION=“latest”
STATIC_CHECK_VERSION=“2023.1.2”
GOLANGCI_VERSION=“v1.50.0”
DELVE_VERSION=“latest”
GOLANG_TAR=linux-amd64.tar.gz
GOLANG_DOWNLOAD_URL=https://dl.google.com/go/go${GO_VERSION}.${GOLANG_TAR}

if [ -L "/usr/local/bin/go" ]; then
    sudo rm "/usr/local/bin/go"
fi

if [ -d "/usr/local/go" ]; then
  sudo rm -rf "/usr/local/go"
fi

curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz
tar -C /usr/local -xzf golang.tar.gz
rm golang.tar.gz
ln -sf /usr/local/go/bin/go /usr/local/bin/go
rm -rf ${GOLANG_TAR}


go install github.com/jesseduffield/lazygit@latest
go install github.com/fatih/gomodifytags@latest
go install github.com/josharian/impl@latest
go get -u github.com/cweill/gotests/...
go get -u github.com/koron/iferr


STATIC_CHECK_VERSION=“2023.1.2”
GOLANGCI_VERSION=“v1.50.0”
DELVE_VERSION=“latest”
go install honnef.co/go/tools/cmd/staticcheck@v1.50.0
go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.50.0
go install github.com/go-delve/delve/cmd/dlv@latest

go install golang.org/x/tools/gopls@”$GOPLS_VERSION”

go_versions=(
go1.19.2
go1.22.6
)

selected_version=$(printf "%s\n" "${go_versions[@]}" | fzf)

LOGFILE="$SKYRAMPDIR/logfile.log"

for version in "${go_versions[@]}"; do
    if [ "$version" == "$selected_version" ]; then
        install_go $version
    fi
done

