FROM debian:buster

RUN apt update \
    && apt install -y \
        curl \
        unzip \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Kubectl
RUN curl -o kubectl -L https://storage.googleapis.com/kubernetes-release/release/v1.14.1/bin/linux/amd64/kubectl \
    && mv kubectl /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

# Google Cloud CLI, for authenticating against GKE clusters.
RUN apt-get update \
    && apt-get install -y lsb-release gnupg2 \
    && CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" \
    && echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && apt-get update \
    && apt-get install -y google-cloud-sdk \
    && rm -rf /var/lib/apt/lists/*

# AWS CLI, for authenticating against EKS clusters.
RUN curl -o awscliv2.zip -L https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip aws

# Useful for dealing with host config.
# We mount stuff in there.
RUN mkdir -p /opt/google-cloud-sdk/bin/
RUN ln -s /usr/bin/gcloud /opt/google-cloud-sdk/bin/gcloud
