require 'spec_helper'
require 'aws-sdk'

describe 'Lambda cloudwatch event trigger' do

  context 'event rule' do

    let (:cw_event_rule_id) {output_for(:harness, 'cloudwatch_event_rule_id')}

    subject {cloudwatch_event(cw_event_rule_id)}
    it {should exist}

  end

end