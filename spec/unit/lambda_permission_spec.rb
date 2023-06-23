# frozen_string_literal: true

require 'spec_helper'
require 'base64'
require 'digest'

describe 'lambda permission' do
  let(:lambda_function_name) do
    output(role: :prerequisites, name: 'lambda_function_name')
  end

  describe 'by default' do
    before(:context) do
      @plan = plan(role: :root)
    end

    it 'creates a lambda permission' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_lambda_permission')
              .once)
    end

    it 'allows lambda function invocation' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_lambda_permission')
              .with_attribute_value(
                :action, 'lambda:InvokeFunction'
              ))
    end

    it 'uses the provided lambda function name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_lambda_permission')
              .with_attribute_value(
                :function_name, lambda_function_name
              ))
    end

    it 'allows events as the principal' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_lambda_permission')
              .with_attribute_value(
                :principal, 'events.amazonaws.com'
              ))
    end
  end
end
