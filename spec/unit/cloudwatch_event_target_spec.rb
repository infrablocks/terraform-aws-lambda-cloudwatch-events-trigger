# frozen_string_literal: true

require 'spec_helper'
require 'base64'
require 'digest'

describe 'cloudwatch event target' do
  let(:lambda_arn) do
    output(role: :prerequisites, name: 'lambda_arn')
  end

  describe 'by default' do
    before(:context) do
      @plan = plan(role: :root)
    end

    it 'creates a cloudwatch event target' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_cloudwatch_event_target')
              .once)
    end

    it 'uses the provided lambda ARN' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_cloudwatch_event_target')
              .with_attribute_value(:arn, lambda_arn))
    end
  end
end
