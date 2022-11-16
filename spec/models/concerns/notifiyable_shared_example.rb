require 'rails_helper'

# think about how to make these callbacks not fire when running tests

RSpec.shared_examples 'notifiyable' do
  describe 'Associations' do
    it { is_expected.to have_many(:notifications).dependent(:destroy) }
    it { is_expected.to have_many(:notified_users).through(:notifications).source(:target).class_name('User') }
  end

  describe 'Callbacks' do
    let(:notifiyable) { build(subject.class.name.underscore) }
    before { allow(notifiyable).to receive(:notification_targets).and_return([]) }

    it 'should call the notify method after creating a notifyable' do
      expect(notifiyable).to receive(:notify)
      notifiyable.save
    end

    it 'should call the notification_targets method after creating a notifyable' do
      expect(notifiyable).to receive(:notification_targets)
      notifiyable.save
    end
    it 'should have methods overriden' do
      expect { notifiyable.save }.to_not raise_error
    end
  end
end
