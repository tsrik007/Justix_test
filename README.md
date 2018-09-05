# Justix Test Code
==================

This is the test code for the requirement given as part of the test.

General Requirements
------------

-	[Terraform](https://www.terraform.io/downloads.html)
-	[Docker](https://docs.docker.com/install/)

### Setup

Clone this repo with `git clone https://github.com/tsrik007/Justix_testws.git` and `cd` to the project. In the main project directory, you'll see the file *terraform.tfvars* and add your personal info to it. You should make sure you never check this file into git/Github.

Next, take a look at the *variables.tf* file. You don't need to change any of them, but if you wanted to change the number of web servers that get deployed, that's where you'd do so. Part of the point of terraform is to keep infrastructure configuration changes under version control (for example, you'd want to make commits after any `terraform apply` or `terraform destroy` actions).

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
