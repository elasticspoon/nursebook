require 'rails_helper'

RSpec.describe Request, type: :model do
  let(:request) { create(:request) }
  subject { request }

  describe 'Associations' do
    it { should belong_to(:sender).class_name('User').inverse_of(:outgoing_friend_requests) }
    it {
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
  end

  describe 'Callbacks' do
  end
end
