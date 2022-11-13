require 'rails_helper'

RSpec.describe LikedPost, type: :model do
  let(:liked_post) { create(:liked_post) }
  subject { liked_post }
  describe 'Associations' do
    it { should belong_to(:user).counter_cache(:liked_posts_cache) }
    it { should belong_to(:post).counter_cache(:likes_count) }
  end
end
