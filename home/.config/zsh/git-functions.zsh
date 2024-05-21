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
}

function makeall() {
    setgo 1.19.4
    pushd $SKYRAMP_HOME
    make all
    make build-worker
    make ecr-login
    make upload-worker
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

function prune() {
    sudo docker system prune -a
}

function syncso() {
    dest=~/git/letsramp/skyramp/libs/pip/src/skyramp/lib/
    rm -rf $dest/*
    rsync -av ~/git/letsramp/skyramp/bin/github.com/letsramp/* $dest
}

function zapns() {
  # Define the array of namespaces
  namespaces=(
    "chaining-test"
    "eks-test"
    "grpc-checkout-test"
    "grpc-test"
    "rest-test
    "kube-node-lease"
    "rafay-test"
    "rbac"
    "rest-checkout-test"
    "rest-test-with-no-openapi"
    "test-rafay"
  )

  # Iterate over the array and delete each namespace with --force
  for namespace in "${namespaces[@]}"; do
    echo "Deleting namespace: $namespace"
    kubectl delete namespace "$namespace" --force --grace-period=0 2>/dev/null
    if [[ $? -eq 0 ]]; then
      echo "Successfully deleted namespace: $namespace"
    else
      echo "Failed to delete namespace: $namespace (ignoring error)"
    fi
  done
}
