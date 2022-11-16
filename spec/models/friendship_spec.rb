# rubocop:disable Metrics/BlockLength
require 'rails_helper'
require_relative 'concerns/notifiyable_shared_example'

RSpec.describe Friendship, type: :model do
  let(:friendship) { create(:friendship) }
  subject { friendship }

  include_examples 'notifiyable'

  describe 'Associations' do
    it { should belong_to(:user_one).class_name('User').counter_cache(:friends_cache) }
    it { should belong_to(:user_two).class_name('User').counter_cache(:friends_cache) }
  end

  describe 'Validations' do
    context 'when friendship already exists' do
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

    context 'when request already exists' do
      let(:request) { create(:request) }
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
  end
end

# rubocop:enable Metrics/BlockLength
