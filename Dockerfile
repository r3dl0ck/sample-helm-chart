FROM registry.redhat.io/openshift4/ose-jenkins-agent-base

RUN wget https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/helm/latest/helm-linux-amd64 -o /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm
