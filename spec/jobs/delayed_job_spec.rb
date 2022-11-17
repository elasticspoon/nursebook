require 'rails_helper'

RSpec.describe DelayedJob, type: :job do
  it 'should call arguments on the object' do
    object = double('object')
    expect(object).to receive(:public_send).with(:method, :arg)
    DelayedJob.perform_now(object, :method, :arg)
  end
end
