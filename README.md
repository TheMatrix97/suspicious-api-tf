# Suspicious API TF

This project includes the required Terraform Files to deploy a `t3.micro` EC2 instance with Docker installed, along with a deployment of `markittos1/susapi:latest` image in port 80.
You can find the Node project here: [https://github.com/TheMatrix97/suspicious-api-js](https://github.com/TheMatrix97/suspicious-api-js)


## Deploy TF resources

```bash
$ cd ./src
$ terraform init
$ terraform apply
```