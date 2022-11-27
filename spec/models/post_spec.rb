# rubocop:disable Lint/EmptyBlock, Metrics/BlockLength
require 'rails_helper'
require_relative 'concerns/likeable_shared_example'

RSpec.describe Post, type: :model do
  let(:post) { create(:post) }
  subject { post }

  include_examples 'likeable', :post

  describe 'Associations' do
    it { should belong_to(:creator).inverse_of(:posts).class_name('User').validate(false).optional(true) }
    it { should have_many(:comments).dependent(:destroy).inverse_of(:parent).counter_cache(:direct_comments_count) }
    it { should have_many(:total_comments).dependent(:destroy).class_name('Comment').counter_cache(:comments_count) }
    it { should have_many_attached(:images) }
  end
  describe 'Validations' do
    it { should validate_presence_of(:creator).on(:create) }
  end

  describe 'Callbacks' do
  end

  describe '#liked_by?' do
    let(:liked_post) { build_stubbed(:liked_post) }
    let(:user) { liked_post.user }
    let(:post) { liked_post.target }

    it 'returns true if the post is liked by the user' do
      allow(post).to receive(:likers).and_return([user])
      expect(post.liked_by?(user)).to be true
    end
    it 'returns false if the post is not liked by the user' do
      expect(post.liked_by?(user)).to be false
    end
    it 'returns false if the user is nil' do
      expect(post.liked_by?(nil)).to be false
    end
  end
end

# rubocop:enable Lint/EmptyBlock, Metrics/BlockLength
