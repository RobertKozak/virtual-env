FROM ubuntu:18.04 as build

# add credentials on build
ARG SSH_PRIVATE_KEY

COPY . .

SHELL ["/bin/bash", "-c"]

# install git
RUN apt-get update
RUN apt-get install -y git curl 

RUN mkdir /root/.ssh/
RUN echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa && chmod 400 /root/.ssh/id_rsa

# make sure your domain is accepted
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN git clone git@github.com:Chrome-River/ansible.git

RUN find ./ansible -maxdepth 1  \( -not -name ansible -not -name c4-dev -not -name plays -not -name inv -not -name group_vars -not -name templates -not -name props \) -exec rm -rf '{}' \;
RUN find ./ansible/group_vars -maxdepth 1  \( -not -name group_vars -not -name c4_dev -not -name c4_all -not -name all -not -name all_dev \) -exec rm -rf '{}' \;

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.17.9/bin/linux/amd64/kubectl
RUN chmod u+x kubectl && mv kubectl /bin/kubectl

RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
RUN chmod 700 get_helm.sh
RUN ./get_helm.sh

# Actual image
FROM amazon/aws-cli

RUN curl -o epel-release-latest-7.noarch.rpm http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    rpm -ivh epel-release-latest-7.noarch.rpm && \
    yum update -y && \
    yum install ansible -y && \
    yum clean all -y && \
    rm -rf epel-release-latest-7.noarch.rpm /var/cache/yum 

COPY --from=build ansible ./ansible/
COPY --from=build /bin/kubectl /bin/kubectl
COPY --from=build config /root/.kube/
COPY --from=build bin/add-branch /usr/bin/
COPY --from=build bin/remove-branch /usr/bin/
COPY --from=build bin/deploy-service /usr/bin/
COPY --from=build service/ ./service/
COPY --from=build /usr/local/bin/helm /usr/bin/

ENTRYPOINT ["/bin/sh"]
