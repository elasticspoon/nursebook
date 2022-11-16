# rubocop:disable Metrics/BlockLength
require 'rails_helper'
require_relative 'concerns/notifiyable_shared_example'

RSpec.describe Request, type: :model do
  let(:request) { create(:request) }
  subject { request }

  include_examples 'notifiyable'

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
    it { should allow_value(false).for(:accepted).on(:create) }
    it { should_not allow_value(true).for(:accepted).on(:create) }

    context 'when request already exists' do
      let(:request_copy) { build(:request, sender: request.sender, receiver: request.receiver) }
      let(:request_copy_reversed) { build(:request, sender: request.receiver, receiver: request.sender) }

      it 'should not allow a request to be created if one already exists' do
        expect(request_copy).to_not be_valid
        expect(request_copy_reversed).to_not be_valid
      end

      it 'should add the Request model to the errors if a request already exists' do
        request_copy.valid?
        request_copy_reversed.valid?
        expect(request_copy.errors[:base]).to include("Request already exists: #{request.inspect}")
        expect(request_copy_reversed.errors[:base]).to include("Request already exists: #{request.inspect}")
      end
    end

    context 'when friendship already exists' do
      let(:friendship) { create(:friendship) }
      let(:friendship_copy) { build(:friendship, user_one: friendship.user_one, user_two: friendship.user_two) }
      let(:friendship_copy_reversed) do
        build(:friendship, user_one: friendship.user_two, user_two: friendship.user_one)
      end

      it 'should not allow a friendship to be created if one already exists' do
        expect(friendship_copy).to_not be_valid
        expect(friendship_copy_reversed).to_not be_valid
      end

      it 'should add the Friendship model to the errors if a friendship already exists' do
        friendship_copy.valid?
        friendship_copy_reversed.valid?
        expect(friendship_copy.errors[:base]).to include("Friendship already exists: #{friendship.inspect}")
        expect(friendship_copy_reversed.errors[:base]).to include("Friendship already exists: #{friendship.inspect}")
      end
    end
  end

  describe 'Callbacks' do
    it 'should create a friendship when the request is accepted' do
      request.update(accepted: true)
      friendship = Friendship.where(user_one: request.sender, user_two: request.receiver).take
      friendship_reversed = Friendship.where(user_one: request.receiver, user_two: request.sender).take
      expect(friendship || friendship_reversed).to be_truthy
    end

    it 'should destroy itself when the request is accepted' do
      request.update(accepted: true)
      expect(request).to be_destroyed
    end
  end
end

# rubocop:enable Metrics/BlockLength
