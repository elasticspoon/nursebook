# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  subject { user }
  describe 'Associations' do
    it { should have_many(:posts).dependent(false).inverse_of(:creator).counter_cache(:posts_cache) }
    it { should have_many(:user_liked_posts).dependent(:destroy).inverse_of(:user).class_name('LikedPost') }
    it { should have_many(:liked_posts).through(:user_liked_posts).source(:post).counter_cache(:liked_posts_cache) }
    it { should have_many(:comments).inverse_of(:creator).dependent(false).counter_cache(:comments_cache) }
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
