# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  subject { user }
  describe 'Associations' do
    # Posts
    it { should have_many(:posts).dependent(false).inverse_of(:creator).counter_cache(:posts_cache) }
    it { should have_many(:user_liked_posts).dependent(:destroy).inverse_of(:user).class_name('LikedPost') }
    it { should have_many(:liked_posts).through(:user_liked_posts).source(:post).counter_cache(:liked_posts_cache) }

    # Comments
    it { should have_many(:comments).inverse_of(:creator).dependent(false).counter_cache(:comments_cache) }
    it { should have_many(:user_liked_comments).dependent(:destroy).inverse_of(:user).class_name('LikedComment') }
    it {
      should have_many(:liked_comments).through(:user_liked_comments)
        .source(:comment).counter_cache(:liked_comments_cache)
    }
    it { should have_one(:profile).dependent(:destroy).class_name('UserProfile') }

    # Friend Requests
    it {
      should have_many(:outgoing_friend_requests).dependent(:destroy)
        .inverse_of(:sender).class_name('Request').with_foreign_key(:sender_id)
    }
    it {
      should have_many(:incoming_friend_requests).dependent(:destroy)
        .inverse_of(:receiver).class_name('Request').with_foreign_key(:receiver_id)
        .counter_cache(:friend_requests_cache)
    }
    it { should have_many(:request_senders).through(:incoming_friend_requests).source(:sender) }
    it { should have_many(:request_targets).through(:outgoing_friend_requests).source(:receiver) }

    # Freindships
    it { should have_many(:friendships).dependent(:destroy).with_foreign_key(:user_one_id).inverse_of(:user_one) }
    it { should have_many(:friends).through(:friendships).source(:user_two).counter_cache(:friends_cache) }

    # Notifications
    it { should have_many(:notifications).dependent(:destroy).inverse_of(:target).with_foreign_key(:target_id) }
  end

  describe 'Association Scope Tests' do
    let(:friendship) { create(:friendship) }
    context 'when users queries thier friendships' do
      it 'should return the friendship for both users' do
        user_one = friendship.user_one
        user_two = friendship.user_two
        expect(user_one.friendships).to match_array([friendship])
        expect(user_two.friendships).to match_array([friendship])
      end
    end

    context 'when users queries their friends' do
      it 'should return the correct friend for both users' do
        user_one = friendship.user_one
        user_two = friendship.user_two
        expect(user_one.friends).to match_array([user_two])
        expect(user_two.friends).to match_array([user_one])
      end
    end
  end

  describe 'Validations' do
  end

  describe 'Callbacks' do
    it 'should nullify dependents on deletion' do
      expect(user).to receive(:nullify_dependents)
      user.destroy
    end

    it 'should nullify posts on deletion' do
      post = create(:post, creator: user)
      user.destroy
      expect(post.reload.user_id).to be_nil
    end

    it 'should nullify comments on deletion' do
      comment = create(:comment, creator: user)
      user.destroy
      expect(comment.reload.user_id).to be_nil
    end
  end
end

# rubocop:enable Metrics/BlockLength
