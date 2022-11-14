# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.describe Request, type: :model do
  let(:request) { create(:request) }
  subject { request }

  describe 'Associations' do
    it { should belong_to(:sender).class_name('User').inverse_of(:outgoing_friend_requests) }
    it {
      puts subject.inspect
      should belong_to(:receiver)
        .class_name('User')
        .inverse_of(:incoming_friend_requests)
        .counter_cache(:friend_requests_cache)
    }
  end

  describe 'Database' do
    it { should have_db_column(:accepted).with_options(default: false) }
  end

  describe 'Validations' do
    it { should allow_value(false).for(:accepted) }
    it { should_not allow_value(true).for(:accepted) }

    it 'should not allow a request to be created if one already exists' do
      request
      request_copy = build(:request, sender: request.sender, receiver: request.receiver)
      request_copy_reversed = build(:request, sender: request.receiver, receiver: request.sender)
      expect(request_copy).to_not be_valid
      expect(request_copy_reversed).to_not be_valid
    end
  end

  describe 'Callbacks' do
  end
end

# rubocop:enable Metrics/BlockLength
