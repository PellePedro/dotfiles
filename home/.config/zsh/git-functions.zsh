export SKYRAMP_HOME=~/git/letsramp/skyramp

function sha() { 
    export SHA=$(git rev-parse --short HEAD)
    echo "SHA is : $SHA"
}

function rmsky() {
    pushd $SKYRAMP_HOME
    docker ps | grep worker | awk '{print $1}' | xargs -I{} docker rm {} --force
    docker ps | grep public.ecr | awk '{print $1}' | xargs -I{} docker rm {} --force
    ~/git/letsramp/skyramp/bin/skyramp cluster remove -l || true
    rm -f ~/.kube/config || true
    popd 
}

function makeall() {
    pushd $SKYRAMP_HOME
    make all
    make build-worker
    make build-so
    make package-pip
    make pip-install
    export SHA=$(git rev-parse --short HEAD)
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
