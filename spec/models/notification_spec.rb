require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:notification) { create(:notification) }
  subject { notification }

  describe 'Associations' do
    it { is_expected.to belong_to(:source) }
    it { is_expected.to belong_to(:target).class_name('User') }
  end

  describe 'Validations' do
    it { is_expected.to validate_inclusion_of(:status).in_array(Notification::NOTIFICATION_STATES) }
  end

  describe 'Callbacks' do
  end
end
