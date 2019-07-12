require 'spec_helper'
require 'aws-sdk'

describe 'Lambda' do

  context 'Lambda' do

    let(:lambda_name) {vars.lambda_function_name}
    let(:lambda_runtime) {vars.lambda_function_name}
    let(:runtume) {vars.lambda_function_name}
    let(:handler) {vars.lambda_handler}

    subject {lambda(lambda_name)}
    it {should exist}

    it {should have_env_vars(["TEST_ENV_VARIABLE"])}

    its(:runtime) {should eq "nodejs10.x"}
    its(:memory_size) {should eq 128}
    its(:timeout) {should eq 30}
    its(:handler) {should eq handler}

  end

  context 'security group' do
    let(:security_group_name) {output_for(:harness, 'security_group_name')}

    subject {security_group(security_group_name)}
    it {should exist}
  end

  context 'IAM policy' do
    let(:lambda_policy) {output_for(:harness, 'iam_role_policy_name')}
    subject {iam_policy(lambda_policy)}
    it {should exist}
  end

end