Terraform AWS Lambda
===================================

[![CircleCI](https://circleci.com/gh/infrablocks/terraform-aws-lambda.svg?style=svg)](https://circleci.com/gh/infrablocks/terraform-aws-lambda)

A Terraform module for creating a new lambda

The lambda module requires:
* A lambda function packaged as zip
* existing VPC 
 
The lambda resource consists of:
- lambda function
- security group for lambda
- iam role for executing lambda
- iam policy for lambda


Usage
-----

To use the module, include something like the following in your terraform 
configuration:

```hcl-terraform
module "lambda" {
  source  = "infrablocks/lambda/aws"
  region                = "eu-west-2"
  component             = "my-lambda"
  deployment_identifier = "production"

  account_id = "11122233355"
  vpc_id = "VPC-1234"
  lambda_subnet_ids = "subnet-id-1"
  lambda_zip_path = "lambda.zip"
  lambda_ingress_cidr_blocks = "10.10.0.0/16"
  lambda_egress_cidr_blocks = "0.0.0.0/8"
  lambda_environment_variables = '{"TEST_ENV_VARIABLE"="test-value"}'
  lambda_function_name = "lambda-function"
  lambda_handler = "handler.hello"


}
```


### Inputs

| Name                             | Description                                                                   | Default             | Required                             |
|----------------------------------|-------------------------------------------------------------------------------|:-------------------:|:------------------------------------:|
| region                           | AWS Region                         | -                   | yes                                  |
| component| The component for which the load balancer is being created    |- | yes|
| deployment_identifier|An identifier for this instantiation                                           |- | yes |
| account_id|AWS account ID                                           |- | yes |
| vpc_id|VPC to deploy lambda to                                           |- | yes |
| lambda_subnet_ids| subnet ids for the lambda |- | yes |
| lambda_zip_path| location of your lambda zip archive |- | yes |
| lambda_ingress_cidr_blocks| ingress CIDR for lambda |- | yes |
| lambda_egress_cidr_blocks| egress CIDR for lambda |- | yes |
| lambda_function_name| lambda function name |- | yes |
| lambda_handler| handler path for lambda |- | yes |
| lambda_environment_variables| environment variables for lambda|- | yes |


### Outputs

| Name                                    | Description                                               |
|-----------------------------------------|-----------------------------------------------------------|
| lambda_invoke_arn                                     |  The ARN to be used for invoking Lambda Function from API Gateway - to be used in aws_api_gateway_integration's uri
| lambda_arn                                     |   The Amazon Resource Name (ARN) identifying your Lambda Function.|
| lambda_function_name                                     |  function name of the lambda|
| lambda_function_name                                     |  function name of the lambda|
| lambda_handler                                     | The handler of the lambda|
| lambda_last_modified                                     |  The date this resource was last modified|
| lambda_id                                     |  The id of the lambda|
| lambda_memory_size                                     |  The allocated memroy size of the lambda|
| lambda_runtime                                     |  The runtime environment of the lambda|
| lambda_source_code_hash                                     | Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3_* parameters.|
| lambda_source_code_size                                     |  The size in bytes of the function .zip file.|
| lambda_version                                     | Latest published version of your Lambda Function |


Development
-----------

### Machine Requirements

In order for the build to run correctly, a few tools will need to be installed on your
development machine:

* Ruby (2.3.1)
* Bundler
* git
* git-crypt
* gnupg
* direnv

#### Mac OS X Setup

Installing the required tools is best managed by [homebrew](http://brew.sh).

To install homebrew:

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Then, to install the required tools:

```
# ruby
brew install rbenv
brew install ruby-build
echo 'eval "$(rbenv init - bash)"' >> ~/.bash_profile
echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
eval "$(rbenv init -)"
rbenv install 2.3.1
rbenv rehash
rbenv local 2.3.1
gem install bundler

# git, git-crypt, gnupg
brew install git
brew install git-crypt
brew install gnupg

# direnv
brew install direnv
echo "$(direnv hook bash)" >> ~/.bash_profile
echo "$(direnv hook zsh)" >> ~/.zshrc
eval "$(direnv hook $SHELL)"

direnv allow <repository-directory>
```

### Running the build

To provision module infrastructure, run tests and then destroy that infrastructure,
execute:

```bash
./go
```

To provision the module prerequisites:

```bash
./go deployment:prerequisites:provision[<deployment_identifier>]
```

To provision the module contents:

```bash
./go deployment:harness:provision[<deployment_identifier>]
```

To destroy the module contents:

```bash
./go deployment:harness:destroy[<deployment_identifier>]
```

To destroy the module prerequisites:

```bash
./go deployment:prerequisites:destroy[<deployment_identifier>]
```


### Common Tasks

#### Generating an SSH key pair

To generate an SSH key pair:

```
ssh-keygen -t rsa -b 4096 -C integration-test@example.com -N '' -f config/secrets/keys/bastion/ssh
```

#### Managing CircleCI keys

To encrypt a GPG key for use by CircleCI:

```bash
openssl aes-256-cbc \
  -e \
  -md sha1 \
  -in ./config/secrets/ci/gpg.private \
  -out ./.circleci/gpg.private.enc \
  -k "<passphrase>"
```

To check decryption is working correctly:

```bash
openssl aes-256-cbc \
  -d \
  -md sha1 \
  -in ./.circleci/gpg.private.enc \
  -k "<passphrase>"
```

Contributing
------------

Bug reports and pull requests are welcome on GitHub at https://github.com/infrablocks/terraform-aws-network-load-balancer. 
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to 
the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


License
-------

The library is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
