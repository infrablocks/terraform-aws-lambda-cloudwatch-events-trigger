require 'spec_helper'
require 'aws-sdk'

describe 'API Gateway lambda resource' do

  let(:rest_api_id) {output_for(:prerequisites, 'api_gateway_id')}

  context 'API gateway resource' do

    let(:path_part) {vars.resource_path_part}

    subject {api_gateway_resources(rest_api_id, path_part).first}

    its(:path_part) {should eq path_part}

  end


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

  context 'api gateway stage' do

    let(:stage_name) {vars.api_gateway_stage_name}

    subject {api_gateway_stages(rest_api_id).item.first}

    its(:stage_name) {should eq stage_name}

  end


end