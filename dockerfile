# Step 1: Use an official Python runtime as a base image
FROM python:3.9-slim

RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Step 4: Download and install Terraform
RUN curl -fsSL https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip \
    && mv terraform /usr/local/bin/ \
    && rm terraform.zip

# Step 7: Generate SSH Key Pair (optional: add passphrase with -N "<your-passphrase>")
RUN apt-get update && apt-get install -y openssh-client
RUN ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa

WORKDIR /app

COPY . /app

# Step 6: Run the script
CMD ["./start.sh"]
