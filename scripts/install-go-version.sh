#!/bin/bash

set -x
golangci_Version=1.59.0
staticcheck_version=2023.1.2

function install_go()
{
    goVersion=$1
    if [ ! -d $HOME/{goVersion} ]; then
        echo "installing go sdk ${goVersion}"
        go install golang.org/dl/${goVersion}@latest
        ${goVersion} download
    fi
    echo "using go sdk ${goVersion}"
    export GOBIN=$HOME/sdk/$goVersion/bin
    export PATH=$HOME/sdk/$goVersion/bin:$PATH
    go version

    if [ ! -f $GOBIN/golangci-lint ]; then
        echo "installing golangci-lint"
        GOLANGCI_URL=https://github.com/golangci/golangci-lint/releases/download/v${golangci_Version}/golangci-lint-${golangci_Version}-linux-amd64.tar.gz
        wget "$GOLANGCI_URL" 
        tar -xzf "golangci-lint-${golangci_Version}-linux-amd64.tar.gz"
        mv "golangci-lint-${golangci_Version}-linux-amd64/golangci-lint" $GOBIN
        rm -rf "golangci-lint-${golangci_Version}-linux-amd64"
    fi

    if [ ! -f $GOBIN/staticcheck ]; then
        echo "installing staticcheck"
        wget https://github.com/dominikh/go-tools/releases/download/${staticcheck_version}/staticcheck_linux_amd64.tar.gz
        tar -xzf staticcheck_linux_amd64.tar.gz
        mv staticcheck/staticcheck $GOBIN
        rm -rf staticcheck
    fi
}

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

