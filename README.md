Justix Test Code
==================

This is the test code for the requirement given as part of the test.

General Requirements
------------

-	[Terraform](https://www.terraform.io/downloads.html)
-	[Docker](https://docs.docker.com/install/)

Clone the code repository

```sh
$ git clone https://github.com/tsrik007/Justix_testws.git ;
```
Fill the required details in terraform.tfvars file.

```sh
$ export TF_VAR_access_key=""

$ export TF_VAR_secret_key=""

$ export TF_VAR_private_key=""
```
Execute the below mentioned terraform commands to provision the requirement.

```sh
$ terraform init

$ terraform plan

$ terraform apply
```

Execute the docker command to run the mysql container.

```sh
docker run --name=test-mysql mysql
```
