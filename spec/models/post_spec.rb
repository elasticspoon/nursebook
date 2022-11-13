require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { create(:post) }
  subject { post }
  describe 'Associations' do
    it { should belong_to(:creator).inverse_of(:posts).class_name('User').validate(false).optional(true) }
    it { should have_many(:user_liked_posts).dependent(:destroy).inverse_of(:post).class_name('LikedPost') }
    it { should have_many(:likers).through(:user_liked_posts).source(:post).counter_cache(:likes_count) }
  end
  describe 'Validations' do
    it { should validate_presence_of(:creator).on(:create) }
  end

  describe 'Callbacks' do
  end
end
