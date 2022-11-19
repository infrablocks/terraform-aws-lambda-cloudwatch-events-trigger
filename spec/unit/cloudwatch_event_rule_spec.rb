# frozen_string_literal: true

require 'spec_helper'
require 'base64'
require 'digest'

describe 'cloudwatch event rule' do
  describe 'by default' do
    before(:context) do
      @plan = plan(role: :root)
    end

    it 'creates a cloudwatch event rule' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_cloudwatch_event_rule')
              .once)
    end

    it 'uses a schedule expression of "rate(5 minutes)"' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_cloudwatch_event_rule')
              .with_attribute_value(:schedule_expression, 'rate(5 minutes)'))
    end

    it 'output the cloudwatch event rule ID' do
      expect(@plan)
        .to(include_output_creation(name: 'cloudwatch_event_rule_id'))
    end
  end

  describe 'when lambda_schedule_expression is provided' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.lambda_schedule_expression = 'rate(10 minutes)'
      end
    end

    it 'creates a cloudwatch event rule' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_cloudwatch_event_rule')
              .once)
    end

    it 'uses the provided schedule expression' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_cloudwatch_event_rule')
              .with_attribute_value(:schedule_expression, 'rate(10 minutes)'))
    end
  end
end
