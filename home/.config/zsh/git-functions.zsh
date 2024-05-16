export SKYRAMP_HOME=~/git/letsramp/skyramp

function sha() { 
    export SHA=$(git rev-parse --short HEAD)
    echo "SHA is : $SHA"
}

function rmcluster() {
    docker ps | grep worker | awk '{print $1}' | xargs -I{} docker rm {} --force
    docker ps | grep public.ecr | awk '{print $1}' | xargs -I{} docker rm {} --force
    ${SKYRAMP_HOME}/bin/skyramp cluster remove -l || true
    rm -f ~/.kube/config || true
}

function newcluster() {
    rmcluster
    ${SKYRAMP_HOME}/bin/skyramp cluster create -l || true
    cp ~/.skyramp/kind-cluster.kubeconfig ~/.kube/config
    rm -f ~/.kube/config || true
}

function makeall() {
    pushd $SKYRAMP_HOME
    make all
    make build-worker
    make build-so
    make package-pip
    make pip-install
    export SHA=$(git rev-parse --short HEAD)
    popd
}

function testpip() {
    rmcluster
    makeall
    pushd $SKYRAMP_HOME
    export SHA=$(git rev-parse --short HEAD)
    make test-pip
    popd
}

function zocat() {
    localhost_port=$1
    host_port=$2
    socat TCP-LISTEN:$host_port,fork TCP:127.0.0.1:$localhost_port
}


function zdelns() {
    NS=$(kubectl get ns | awk '{print $1}' | fzf)
    kubectl delete ns $NS
}

function zdelns() {
    image=$(kubectl get ns | awk '{print $1}' | fzf)
    kubectl delete ns $NS
}

function installgo() {
    version=$1
    go install golang.org/dl/go$version@latest
    go$version download
}

function setgo() {
    version=$1
    GOROOT=$(go$version env GOROOT)
    export PATH=$GOROOT/bin:$PATH
    GOPATH=$(go$version env GOPATH)
    export GOPATH
}
