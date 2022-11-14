# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { create(:comment) }
  subject { comment }

  describe 'Associations' do
    it {
      should belong_to(:creator).inverse_of(:comments).class_name('User')
        .optional(true).counter_cache(:comments_cache).with_foreign_key(:user_id)
    }
    it { should belong_to(:post).counter_cache(:comments_count) }
    it { should belong_to(:parent).counter_cache(:direct_comments_count) }
    it {
      should have_many(:comments).dependent(:destroy).inverse_of(:parent)
        .counter_cache(:direct_comments_count)
    }
    it { should have_many(:user_liked_comments).dependent(:destroy).inverse_of(:comment).class_name('LikedComment') }
    it { should have_many(:likers).through(:user_liked_comments).source(:user).counter_cache(:likes_count) }
  end

  describe 'Validations' do
    it 'uses parent post_id as post_id if parent is a comment' do
      post = create(:post)
      comment = create(:comment, parent: post, post:)
      sub_comment = create(:comment, parent: comment, post:)
      expect(sub_comment.post_id).to eq(post.id)
    end
  end

  describe 'Callbacks' do
  end
end

# rubocop:enable Metrics/BlockLength
