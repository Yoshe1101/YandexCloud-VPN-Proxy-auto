# Intro

This is a terraform module/script to create a VM in Yandex Cloud with the Goal of using it as a VPN/Proxy server from the Russian Region.
The settings chosen are the cheapest I have found and the idea is to deploy it when is going to be used and then destroy it.

# Requiretments

#### Yandex Cloud account.
For this purpose we have choosen the Yandex Cloud service because is on of the only Cloud providers with available VMs in the Russian region.

#### Cloudflare account and a domain. (Optional)
Every time the VM is created the IP will change. To avoid checking the IP every time the service is deployed we are gonna use a Cloudflare docker image to update automatically the DNS IP record for the domain.

# setup

### Yandex Cloud terraform provider.
You can find [here](https://yandex.cloud/en/docs/tutorials/infrastructure-management/terraform-quickstart) where how to set up the Yandex Cloud Terraform provider, but I will summarise it here:

First is necessary to install yc (yandex cloud) cli. Check [here](https://yandex.cloud/en/docs/cli/operations/install-cli) where how to install in depending on your OS.

Then you will need to create a key.json file.

```
yc iam key create \
  --service-account-id [Yandex account ID] \
  --folder-name [Folder name] \
  --output key.json
```

Then, it is necessary to create a service account withthin the same folder we want to deploy our resources. You can find [here](https://yandex.cloud/en/docs/iam/operations/sa/create) where how to do it.

Once we have the ervice account created, we have to give it the proper permissions:

```
yc resource-manager folder add-access-binding [Folder ID] \
  --role resource-manager.admin \
  --subject serviceAccount:[Service account ID]
```

Then run the following commands to create the env variables that the terraform provider needs:

``` 
yc config set service-account-key key.json
yc config set cloud-id [Yandex account ID]
yc config set folder-id [Folder ID]

export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)
```

### Variables.

#### Terraform variables:
Modify the **tf.tfvars** file with the values that you want to use.
Change the values depending on your Yandex Cloud account folder network resoruces.
You can also change the zone, image-id and vm-name.

```
export TF_VAR_networkid=
export TF_VAR_subnetid=
export TF_VAR_vmname=
export TF_VAR_zone="ru-central1-a"               # Change if necessary
export TF_VAR_imageid="fd8j0uq7qcvtb65fbffl"     # Ubuntu 24.04 LTS
```
#### VPN/porxy variables:
In the **.env** file in the files folder, create a password for the VPN/Proxy service and in case you are using a Domain in Cloudflare, add the CloudFlare API key and the domain name (more info how to create Cloudflare API for Dynamic IP [Docker image](https://hub.docker.com/r/oznu/cloudflare-ddns/) and [Cloudflare documentation](https://dash.cloudflare.com/profile/api-tokens)): 
```
shadowsocks_password =

(Optional Cloudflare variables)

export cloudflare_api_key=
export domain=
```


### Terraform deployment.
Once you have the Yandex Cloud terraform provider and the env variables, you can run the following command to deploy the VM:

````
terraform init
terraform apply -auto-approve
```

If everything goes as expected you should see the Public IP of the VM and be able to connect to the VPN/Proxy server.

### VPN/Proxy server.

In this case we are using Shadowsocks because it is the most popular, secure and simple VPN/Proxy server.

If you use an Iphone or Android phone I recomend using the [Potatso app](https://www.potatsolab.com) to connect.
[iOS](https://apps.apple.com/es/app/potatso/id1239860606?l=en-GB)
[Andorid](To be tested, but I guess any shadowsocks android app client should work)

To configure it just add the public IP of the VM (or the public IP of the domain) to the potatso client password that you chose in the variables.
By default the encryption is aes-256-gcm and the port is 8388 (It is possible to change it in the docker-compose.yaml file in the files folder).