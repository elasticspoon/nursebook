require 'rails_helper'

RSpec.describe LikedComment, type: :model do
  let(:liked_comment) { create(:liked_comment) }
  subject { liked_comment }

  describe 'Associations' do
    it { should belong_to(:user).counter_cache(:liked_comments_cache) }
    it { should belong_to(:comment).counter_cache(:likes_count) }
  end
end
