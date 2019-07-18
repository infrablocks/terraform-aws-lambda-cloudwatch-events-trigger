Terraform AWS Lambda CloudWatch events trigger
===================================

[![CircleCI](https://circleci.com/gh/infrablocks/terraform-aws-lambda-cloudwatch-events-trigger.svg?style=svg)](https://circleci.com/gh/infrablocks/terraform-aws-lambda-cloudwatch-events-trigger)

A Terraform module for triggering lambdas on schedule

The lambda module requires:
* A lambda function
 
The lambda resource consists of:
- cloudwatch event rule
- permissions to execute lambda with cloudwatch event


Usage
-----

To use the module, include something like the following in your terraform 
configuration:

```hcl-terraform
module "lambda-cloudwatch-trigger" {
  source  = "infrablocks/lambda-cloudwatch-events-trigger/aws"
  region                = "eu-west-2"
  component             = "my-lambda"
  deployment_identifier = "production"
  
  lambda_arn =  "arn:eu-west-1:example-lambda"
  lambda_function_name = "my-lambda"
  lambda_schedule_expression = "rate(2 days)"
}

module "lambda-cloudwatch-trigger" {
  source  = "infrablocks/lambda-cloudwatch-events-trigger/aws"
  region                = "eu-west-2"
  component             = "my-lambda2"
  deployment_identifier = "production"
  
  lambda_arn =  "arn:eu-west-1:example-lambda"
  lambda_function_name = "my-lambda2"
  lambda_schedule_expression = "cron(0 20 * * ? *)"
}
```


### Inputs

| Name                             | Description                                                                   | Default             | Required                             |
|----------------------------------|-------------------------------------------------------------------------------|:-------------------:|:------------------------------------:|
| region                           | AWS Region                         | -                   | yes                                  |
| component| The component for which the load balancer is being created    |- | yes|
| deployment_identifier|An identifier for this instantiation                                           |- | yes |
| lambda_arn|Lambda ARN                                           |- | yes |
| lambda_function_name|Name of the Lambda function                                           |- | yes |
| lambda_schedule_expression|Lambda schedule expression. Defaults to every 5 minutes                                           |rate(5 minutes)| yes |


### Outputs

| Name                                    | Description                                               |
|-----------------------------------------|-----------------------------------------------------------|


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
