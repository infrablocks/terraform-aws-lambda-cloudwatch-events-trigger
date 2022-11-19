# frozen_string_literal: true

require 'spec_helper'

describe 'full' do
  let(:cloudwatch_event_rule_id) do
    output(role: :full, name: 'cloudwatch_event_rule_id')
  end

  before(:context) do
    apply(role: :full)
  end

  after(:context) do
    destroy(
      role: :full,
      only_if: -> { !ENV['FORCE_DESTROY'].nil? || ENV['SEED'].nil? }
    )
  end

  describe 'event rule' do
    subject { cloudwatch_event(cloudwatch_event_rule_id) }

    it { is_expected.to exist }
  end
end
